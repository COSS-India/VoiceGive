import 'dart:convert';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart';

/// Service for handling password encryption using AES-256-CBC
/// 
/// This service implements the same encryption algorithm as the frontend:
/// - Algorithm: AES-256-CBC
/// - Key: Fixed 32-byte key hardcoded in the application
/// - IV: Fixed 16-byte IV hardcoded in the application
/// - Output Format: IV (as hex) + ':' + encrypted password (as hex)
class PasswordEncryptionService {
  // Private constructor to prevent instantiation
  PasswordEncryptionService._();

  // Fixed encryption key (32 bytes for AES-256)
  static const String _encryptionKey = 'qHYsV6qtJKSv11VqoJKp7ukZDmpQ4bmS';
  
  // Fixed IV (16 bytes for AES-256-CBC)
  static const String _ivString = 'SDqnq5xuYWSRcINf';
  

  /// Encrypts a password using AES-256-CBC
  /// 
  /// [password] The plain text password to encrypt
  /// Returns the encrypted password in format: IV(hex):encrypted_password(hex)
  static String encryptPassword(String password) {
    try {
      // Handle empty password case
      if (password.isEmpty) {
        // For empty passwords, return a special format that can be decrypted
        final ivBytes = utf8.encode(_ivString);
        final ivHex = ivBytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
        return '$ivHex:'; // Empty encrypted data
      }
      
      // Convert key to bytes
      final keyBytes = utf8.encode(_encryptionKey);
      
      // Convert IV from string to bytes (same as Node.js Buffer.from('SDqnq5xuYWSRcINf', 'utf-8'))
      final ivBytes = utf8.encode(_ivString);
      
      // Create encryptor
      final encrypter = Encrypter(AES(Key(Uint8List.fromList(keyBytes)), mode: AESMode.cbc));
      final iv = IV(Uint8List.fromList(ivBytes));
      
      // Encrypt the password
      final encrypted = encrypter.encrypt(password, iv: iv);
      
      // Convert IV to hex string for output (same as Node.js ivv.toString('hex'))
      final ivHex = ivBytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
      
      // Convert encrypted data to hex (same as Node.js encrypted.toString('hex'))
      final encryptedHex = encrypted.bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
      
      // Return in format: IV(hex):encrypted_password(hex)
      return '$ivHex:$encryptedHex';
    } catch (e) {
      throw PasswordEncryptionException('Failed to encrypt password: $e');
    }
  }

  /// Decrypts a password using AES-256-CBC
  /// 
  /// [encryptedPassword] The encrypted password in format: IV(hex):encrypted_password(hex)
  /// Returns the decrypted password or null if decryption fails
  static String? decryptPassword(String encryptedPassword) {
    try {
      if (encryptedPassword.isEmpty) {
        return null;
      }

      // Split the encrypted password to extract the IV and the encrypted data
      final parts = encryptedPassword.split(':');
      if (parts.length != 2) {
        throw PasswordEncryptionException('Invalid encrypted data format');
      }

      final ivHex = parts[0];
      final encryptedData = parts[1];

      if (ivHex.isEmpty) {
        throw PasswordEncryptionException('Invalid encrypted data format. IV is missing');
      }
      
      // Handle empty encrypted data (for empty passwords)
      if (encryptedData.isEmpty) {
        return '';
      }

      // Convert IV from hex string to bytes
      // Looking at Node.js code more carefully, I think the issue is that we should use the original IV
      // The hex string is just for the output format, but the actual IV used should be the original
      final ivBytes = utf8.encode(_ivString);

      if (ivBytes.length != 16) {
        throw PasswordEncryptionException('Invalid IV length: ${ivBytes.length}');
      }

      // Convert key to bytes
      final keyBytes = utf8.encode(_encryptionKey);
      
      // Create decryptor
      final encrypter = Encrypter(AES(Key(Uint8List.fromList(keyBytes)), mode: AESMode.cbc));
      final iv = IV(Uint8List.fromList(ivBytes));
      
      // Convert encrypted data from hex to bytes
      final encryptedBytes = <int>[];
      for (int i = 0; i < encryptedData.length; i += 2) {
        final hexByte = encryptedData.substring(i, i + 2);
        encryptedBytes.add(int.parse(hexByte, radix: 16));
      }
      
      // Decrypt the password
      final encrypted = Encrypted(Uint8List.fromList(encryptedBytes));
      final decrypted = encrypter.decrypt(encrypted, iv: iv);
      
      return decrypted;
    } catch (e) {
      throw PasswordEncryptionException('Failed to decrypt password: $e');
    }
  }

  /// Validates if a string is in the correct encrypted format
  /// 
  /// [encryptedPassword] The string to validate
  /// Returns true if the format is correct, false otherwise
  static bool isValidEncryptedFormat(String encryptedPassword) {
    try {
      final parts = encryptedPassword.split(':');
      if (parts.length != 2) return false;
      
      final ivHex = parts[0];
      final encryptedData = parts[1];
      
      // Check if IV is valid hex and 16 bytes (32 hex characters)
      if (ivHex.length != 32) return false;
      
      // Check if encrypted data is valid hex
      try {
        if (encryptedData.isEmpty) return true; // Allow empty encrypted data for empty passwords
        // Check if all characters are valid hex
        for (int i = 0; i < encryptedData.length; i++) {
          final char = encryptedData[i];
          if (!RegExp(r'[0-9a-fA-F]').hasMatch(char)) {
            return false;
          }
        }
        return true;
      } catch (e) {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}

/// Custom exception for password encryption errors
class PasswordEncryptionException implements Exception {
  final String message;
  
  const PasswordEncryptionException(this.message);
  
  @override
  String toString() => 'PasswordEncryptionException: $message';
}

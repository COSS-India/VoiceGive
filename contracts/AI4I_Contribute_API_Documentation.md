# AI4I Contribute API Documentation

**Version:** 1.0.0
**Base URL (development):** `http://localhost:9000`
**License:** MIT

> **Naming note:** The product is referred to throughout this document as **AI4I Contribute** (renamed from the original "VoiceGive" branding used in the source specification). Actual API field names, schema names, endpoint paths, and literal example values (such as the support email address) are carried forward unchanged from the source spec, since renaming those would not reflect what the live API actually returns.

## Overview

AI4I Contribute is a mobile-friendly application designed for language data (voice-based) collection and crowdsourcing initiatives. This project provides a complete, customizable user interface that can be adopted by organizations, government agencies, and developers to build their own language voice data collection applications.

**Certificate Requirements:**
- 5 voice contributions
- 25 validations

## Contact

| Field | Value |
|---|---|
| Name | AI4I Contribute Support |
| Email | voicegive.ai4x@gmail.com |

## Servers

| URL | Description |
|---|---|
| `http://localhost:9000` | Development server |

## Authentication

Unless explicitly overridden on an individual operation (see each endpoint's **Security** row below), every endpoint requires a **Bearer JWT** token, obtained via the OTP login flow (`POST /auth/verify-otp`).

```
Authorization: Bearer <accessToken>
```

| Scheme | Type | Format | Description |
|---|---|---|---|
| `BearerAuth` | http (bearer) | JWT | JWT token obtained from OTP verification |

## Tags

| Tag | Description |
|---|---|
| Authentication | Mobile OTP-based authentication and consent management |
| User Profile | User registration and profile management |
| Location | Country, State, and District data |
| System | System checks, language list, and utilities |
| Contribution | Voice recording contributions |
| Validation | Audio-text validation |
| Certificate | Certificate generation and download |
| suno | Listen-based validation module (see [Section 8](#8-additional-modality-modules-suno--likho--dekho)) |
| likho | Text/writing contribution module (see [Section 8](#8-additional-modality-modules-suno--likho--dekho)) |
| dekho | Visual/image contribution module (see [Section 8](#8-additional-modality-modules-suno--likho--dekho)) |

## Table of Contents

1. [Authentication](#1-authentication)
2. [User Profile](#2-user-profile)
3. [Location](#3-location)
4. [System](#4-system)
5. [Contribution](#5-contribution)
6. [Validation](#6-validation)
7. [Certificate](#7-certificate)
8. [Additional Modality Modules (Suno / Likho / Dekho)](#8-additional-modality-modules-suno--likho--dekho)
9. [Data Models (Schemas)](#9-data-models-schemas)
10. [Error Handling](#10-error-handling)
11. [Known Spec Issues](#11-known-spec-issues)
12. [Endpoint Index](#12-endpoint-index)

---

## 1. Authentication

### `POST /auth/send-otp`

Send a 6-digit OTP to the user's mobile number for authentication. The OTP is valid for 5 minutes (300 seconds).

**Security:** None (public endpoint)

**Request body** (`application/json`, required)

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `mobileNo` | string (pattern `^[6-9]\d{9}$`) | Yes | 10-digit Indian mobile number (must start with 6-9) | `"9177454678"` |
| `countryCode` | string | No (default `"+91"`) | Country calling code | `"+91"` |

**Responses**

| Status | Description |
|---|---|
| `200` | OTP sent successfully — returns `sessionId` (uuid), `expiresIn` (300), `expiresAt` (date-time), `isNewUser` (boolean) |
| `400` | Invalid mobile number format (`ErrorResponse`, e.g. `INVALID_MOBILE`) |
| `404` | Number not registered — returns `success`, `error.code` (`USER_NOT_FOUND`), `error.message`, `error.supportEmail`, `error.contactMessage` |
| `429` | Too many OTP requests (`ErrorResponse`) |

---

### `POST /auth/resend-otp`

Resend the OTP if the user didn't receive it. Can only be called after an initial `send-otp` call.

**Security:** None (public endpoint)

**Request body** (`application/json`, required)

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `mobileNo` | string (pattern `^[6-9]\d{9}$`) | Yes | 10-digit Indian mobile number | `"9177454678"` |
| `countryCode` | string | No (default `"+91"`) | Country calling code | `"+91"` |

**Responses**

| Status | Description |
|---|---|
| `200` | OTP resent successfully — returns `success`, `message`, `data.expiresIn` (300), `data.expiresAt` |
| `400` | Invalid or expired session |
| `429` | Too many resend attempts |

---

### `POST /auth/verify-otp`

Verify the 6-digit OTP and obtain a JWT access token. The client-side timer shows remaining time in `mm:ss` format (e.g. `02:32`).

**Security:** None (public endpoint)

**Request body** (`application/json`, required)

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `mobileNo` | string (pattern `^[6-9]\d{9}$`) | Yes | 10-digit Indian mobile number | `"9177454678"` |
| `otp` | string (pattern `^\d{6}$`) | Yes | 6-digit OTP from SMS | `"123456"` |

**Responses**

| Status | Description |
|---|---|
| `200` | OTP verified — returns `accessToken`, `refreshToken`, `tokenType` (`Bearer`), `expiresIn` (86400s / 24h), `user.userId`, `user.mobileNo`, `requiresConsent`, `requiresProfile` |
| `401` | Invalid OTP (`ErrorResponse`, e.g. `INVALID_OTP`) |
| `410` | OTP expired (`ErrorResponse`) |

---

### `POST /auth/consent`

Record acceptance of terms and conditions. The user must accept all three policies before contributing or validating; all checkboxes must be checked to proceed.

**Required documents:**
1. Terms of Use / Contribution Terms
2. Privacy Policy
3. Copyright & Licensing Policy

**Security:** Bearer token required

**Request body** (`application/json`, required)

| Field | Type | Required | Description |
|---|---|---|---|
| `termsAccepted` | boolean | Yes | Terms of Use / Contribution Terms checkbox |
| `privacyAccepted` | boolean | Yes | Privacy Policy checkbox |
| `copyrightAccepted` | boolean | Yes | Copyright & Licensing Policy checkbox |
| `consentText` | object | No | Stores the consent text the user agreed to |
| `consentText.termsVersion` | string | No | Version of Terms accepted |
| `consentText.privacyVersion` | string | No | Version of Privacy Policy accepted |
| `consentText.copyrightVersion` | string | No | Version of Copyright Policy accepted |

**Responses**

| Status | Description |
|---|---|
| `200` | Consent recorded — returns `consentId` (uuid), `consentTimestamp`, `ipAddress` |
| `400` | All consents must be accepted (`ErrorResponse`, `CONSENT_REQUIRED`) |

---

### `POST /auth/logout`

Invalidate the current access token and refresh token.

**Security:** Bearer token required

**Responses**

| Status | Description |
|---|---|
| `200` | Logged out successfully |

---

### `POST /auth/refresh-token`

Get a new access token using a refresh token.

**Security:** None (public endpoint)

**Request body** (`application/json`, required)

| Field | Type | Required | Description |
|---|---|---|---|
| `refreshToken` | string | Yes | Valid refresh token |

**Responses**

| Status | Description |
|---|---|
| `200` | Token refreshed — returns `accessToken`, `tokenType`, `expiresIn` |

---

## 2. User Profile

### `POST /users/register`

Complete the user's profile after OTP verification. Called for new users; all fields are mandatory.

**Flow steps:**
1. Personal Information: First Name, Last Name, Age Group, Gender, Phone, Email
2. Other Information: Country, State, District, Preferred Language

**Security:** Bearer token required

**Request body** (`application/json`, required)

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `firstName` | string (2–50 chars) | Yes | User's first name | `"Ragani"` |
| `lastName` | string (2–50 chars) | Yes | User's last name | `"Shukla"` |
| `ageGroup` | string enum | Yes | `Under 18`, `18-25 years`, `26-30 years`, `31-40 years`, `41-50 years`, `51-60 years`, `Above 60` | `"26-30 years"` |
| `gender` | string enum | Yes | `Male`, `Female`, `Other`, `Prefer not to say` | `"Female"` |
| `mobileNo` | string | No | Auto-filled from OTP authentication (read-only) | `"9177454678"` |
| `email` | string (email) | No | Optional email address | `"ragani.dibd@gmail.com"` |
| `country` | string | Yes | Country selection (dropdown) | `"India"` |
| `state` | string | Yes | State selection (dropdown, filtered by country) | `"Maharashtra"` |
| `district` | string | Yes | District selection (dropdown, filtered by state) | `"Amravati"` |
| `preferredLanguageCode` | string | Yes | Preferred language for contributions (dropdown) | `"mr"` |

**Responses**

| Status | Description |
|---|---|
| `201` | Registration completed — returns `success`, `message`, `data` (`UserProfile`) |
| `400` | Validation error — returns `error.code` (`VALIDATION_ERROR`), `error.message`, `error.field`, `error.validationErrors[]` (`field`, `message`) |

---

### `GET /users/profile`

Retrieve the current user's complete profile information.

**Security:** Bearer token required

**Responses**

| Status | Description |
|---|---|
| `200` | Profile retrieved — returns `success`, `data` (`UserProfile`) |

---

### `PUT /users/profile`

Update the current user's profile information.

**Security:** Bearer token required

**Request body** (`application/json`, required — all fields optional)

| Field | Type |
|---|---|
| `firstName` | string |
| `lastName` | string |
| `ageGroup` | string |
| `gender` | string |
| `email` | string |
| `country` | string |
| `state` | string |
| `district` | string |
| `preferredLanguageCode` | string |

**Responses**

| Status | Description |
|---|---|
| `200` | Profile updated successfully |

---

### `GET /users/stats`

Get the user's contribution and validation counts. Used to track progress toward certificate eligibility.

**Security:** Bearer token required

**Responses**

| Status | Description |
|---|---|
| `200` | Statistics retrieved — returns `contributionCount` (int, e.g. `5`), `validationCount` (int, e.g. `25`), `certificateEligible` (bool), `certificateIssued` (bool), `certificateId` (e.g. `"DIC-20250917-0123"`), `lastContributionDate` (date-time), `lastValidationDate` (date-time) |

---

## 3. Location

### `GET /location/countries`

Get the list of supported countries.

**Security:** None (public endpoint)

**Responses**

| Status | Description |
|---|---|
| `200` | Returns an array of `{ countryId, countryName, countryCode }`, e.g. `{ "countryId": "IN", "countryName": "India", "countryCode": "+91" }` |

---

### `GET /location/states`

Get the list of states for a country.

**Security:** None (public endpoint)

**Query parameters**

| Name | Type | Required | Default | Example |
|---|---|---|---|---|
| `countryId` | string | Yes | `"IN"` | `"IN"` |

**Responses**

| Status | Description |
|---|---|
| `200` | Returns an array of `{ stateId, stateName }`, e.g. `{ "stateId": "MH", "stateName": "Maharashtra" }` |

---

### `GET /location/districts`

Get the list of districts for a state.

**Security:** None (public endpoint)

**Query parameters**

| Name | Type | Required | Example |
|---|---|---|---|
| `stateId` | string | Yes | `"MH"` |

**Responses**

| Status | Description |
|---|---|
| `200` | Returns an array of `{ districtId, districtName }`, e.g. `{ "districtId": "MH-AMR", "districtName": "Amravati" }` |

---

## 4. System

### `GET /system/languages`

Get the list of languages available for contribution and validation.

**Security:** None (public endpoint)

**Responses**

| Status | Description |
|---|---|
| `200` | Returns an array of `{ languageCode, languageName, nativeName, isActive }`, e.g. `{ "languageCode": "mr", "languageName": "Marathi", "nativeName": "मराठी", "isActive": true }` |

---

### `GET /system/test-speaker`

Returns a sample audio file so the user can test their speakers/headphones.

**Security:** Bearer token required

**Responses**

| Status | Content-Type | Description |
|---|---|---|
| `200` | `audio/mpeg` | Sample audio file (binary) |

---

### `POST /system/test-microphone`

Upload a test recording to verify the user's microphone setup and audio quality.

**Security:** Bearer token required

**Request body** (`multipart/form-data`, required)

| Field | Type | Required | Description |
|---|---|---|---|
| `audio` | string (binary) | Yes | Test audio recording |

**Responses**

| Status | Description |
|---|---|
| `200` | Returns `quality` (enum: `excellent`, `good`, `acceptable`, `poor`), `volumeLevel` (0–1 float), `backgroundNoise` (0–1 float), `recommendations[]` (string array) |

---

### `GET /system/health`

Check API server health status and service availability. Used for monitoring, load balancer health checks, and system diagnostics.

**Security:** None (public endpoint)

**Responses**

| Status | Description |
|---|---|
| `200` | System is healthy — returns `status` (enum: `healthy`, `degraded`, `unhealthy`), `timestamp`, `version`, `uptime` (seconds), `services.database`/`services.storage`/`services.external_apis` (enum: `up`, `down`, `degraded`) |
| `503` | Service unavailable — returns `status`, `timestamp`, `issues[]` |

---

### `GET /system/version`

Return the current API version, build information, and deployment details. Useful for client compatibility checks and debugging.

**Security:** None (public endpoint)

**Responses**

| Status | Description |
|---|---|
| `200` | Returns `apiVersion`, `buildVersion`, `buildDate`, `environment` (enum: `development`, `staging`, `production`), `features[]`, `supportedLanguages[]` (`code`, `name`, `nativeName`), `limits` (`maxAudioSize`, `maxAudioDuration`, `sessionTimeout`), `dependencies` (`database`, `cache`, `storage`) |

---

### `GET /system/config`

Get the current system configuration values, including business rules, limits, and settings — all configurable parameters that can be adjusted without code changes.

**Security:** None (public endpoint)

**Responses**

| Status | Description |
|---|---|
| `200` | Returns `data` as a [`SystemConfig`](#systemconfig) object |

---

## 5. Contribution

### `POST /contributions/get-sentences`

Get a batch of sentences to record in the selected language. Returns 5 sentences per session (shown in the UI as `1/5`, `2/5`, etc.).

**Security:** Bearer token required

**Request body** (`application/json`, required)

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `languageCode` | string | Yes | Language code selected from dropdown | `"mr"` |
| `count` | integer | No (default `5`, max `5`) | Number of sentences (fixed at 5) | `5` |

**Responses**

| Status | Description |
|---|---|
| `200` | Returns `sessionId` (uuid), `languageCode`, `sentences[]` (5 items: `sentenceId`, `text`, `sequenceNumber` 1–5, `metadata.category`, `metadata.difficulty`), `totalCount` |

---

### `POST /contributions/record`

Upload an audio recording for a sentence. The user can re-record if not satisfied.

**Security:** Bearer token required

**Request body** (`application/json`, required)

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `sessionId` | string (uuid) | Yes | Session ID from `get-sentences` | |
| `sentenceId` | string | Yes | Sentence ID being recorded | |
| `audioContent` | string (byte) | Yes | Base64-encoded audio content | |
| `duration` | number (float) | Yes | Recording duration in seconds | `20.0` |
| `languageCode` | string | Yes | Language code | `"mr"` |
| `sequenceNumber` | integer | Yes | Position in session (1–5) | `1` |
| `metadata` | string | No | JSON string with device, browser info | |

**Responses**

| Status | Description |
|---|---|
| `201` | Returns `contributionId` (uuid), `audioContent` (base64), `duration`, `status` (enum: `pending`, `accepted`), `sequenceNumber`, `totalInSession`, `remainingInSession`, `progressPercentage` |
| `400` | Invalid audio or exceeded size limit |

---

### `POST /contributions/skip`

Skip the current sentence and get the next one.

**Security:** Bearer token required

**Request body** (`application/json`, required)

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `sessionId` | string (uuid) | Yes | | |
| `sentenceId` | string | Yes | | |
| `reason` | string enum | No | `too_difficult`, `unclear_text`, `inappropriate`, `technical_issue`, `other` | `"too_difficult"` |
| `comment` | string (max 200 chars) | No | | |

**Responses**

| Status | Description |
|---|---|
| `200` | Returns `nextSentence` (`sentenceId`, `text`, `sequenceNumber`) |

---

### `POST /contributions/report`

Report an inappropriate, incorrect, or offensive sentence.

**Security:** Bearer token required

**Request body** (`application/json`, required)

| Field | Type | Required | Description |
|---|---|---|---|
| `sentenceId` | string | Yes | |
| `reportType` | string enum | Yes | `inappropriate`, `incorrect`, `offensive`, `duplicate`, `poor_quality`, `other` |
| `description` | string (max 500 chars) | No | |

**Responses**

| Status | Description |
|---|---|
| `200` | Report submitted — `message` example: `"Report submitted. Thank you for your feedback."` |

---

### `POST /contributions/session-complete`

Mark a session as complete after recording all 5 sentences. Returns certificate eligibility status.

**Security:** Bearer token required

**Request body** (`application/json`, required)

| Field | Type | Required |
|---|---|---|
| `sessionId` | string (uuid) | Yes |

**Responses**

| Status | Description |
|---|---|
| `200` | Returns `sessionId`, `totalContributions`, `userTotalContributions`, and `certificateProgress` (`contributionsCompleted`, `contributionsRequired`, `validationsCompleted`, `validationsRequired`, `isEligible`, `percentageComplete`) |

---

## 6. Validation

### `GET /validations/get-queue`

Get audio recordings that need validation (25 items per session). Returns audio-text pairs for validation.

**Security:** Bearer token required

**Query parameters**

| Name | Type | Required | Default | Description | Example |
|---|---|---|---|---|---|
| `languageCode` | string | Yes | | Language for validation | `"mr"` |
| `count` | integer | No | `25` (max `25`) | | |

**Responses**

| Status | Description |
|---|---|
| `200` | Returns `sessionId` (uuid), `languageCode`, `validationItems[]` (25 items: `contributionId`, `sentenceId`, `text`, `audioContent` (base64), `duration`, `sequenceNumber` 1–25), `totalCount` |

---

### `POST /validations/submit`

Mark an audio recording as Correct or Incorrect.

**Security:** Bearer token required

**Request body** (`application/json`, required)

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `sessionId` | string (uuid) | Yes | | |
| `contributionId` | string (uuid) | Yes | | |
| `sentenceId` | string | No | | |
| `decision` | string enum | Yes | `correct`, `incorrect` | `"correct"` |
| `feedback` | string (max 200 chars) | No | Optional feedback (especially for incorrect validations) | |
| `sequenceNumber` | integer | No | | `1` |

**Responses**

| Status | Description |
|---|---|
| `200` | Returns `validationId` (uuid), `sequenceNumber`, `totalInSession`, `remainingInSession`, `progressPercentage` |
| `400` | Invalid request |
| `422` | Validation conflict (already validated by this user) |

---

### `POST /validations/session-complete`

Mark a validation session as complete after validating all 25 recordings. Checks certificate eligibility after completion.

**Security:** Bearer token required

**Request body** (`application/json`, required)

| Field | Type | Required |
|---|---|---|
| `sessionId` | string (uuid) | Yes |

**Responses**

| Status | Description |
|---|---|
| `200` | Returns `sessionId`, `totalValidations`, `userTotalValidations`, and `certificateProgress` (`contributionsCompleted`, `contributionsRequired`, `validationsCompleted`, `validationsRequired`, `isEligible`, `certificateAvailable`) |

---

## 7. Certificate

### `GET /certificates/check-eligibility`

Check if the user has met certificate requirements (5 voice contributions + 25 validations).

**Security:** Bearer token required

**Responses**

| Status | Description |
|---|---|
| `200` | Returns `isEligible`, `contributionsCompleted`, `contributionsRequired`, `validationsCompleted`, `validationsRequired`, `certificateIssued`, `certificateId`, `percentageComplete` |

---

### `POST /certificates/generate`

Generate a certificate after completing requirements (5 contributions + 25 validations). Fixed certificate title: **"Agri Bhasha Samarthak"**.

**Security:** Bearer token required

**Responses**

| Status | Description |
|---|---|
| `200` | Certificate generated — returns `certificateId` (e.g. `"DIC-20250917-0123"`), `recipientName`, `badgeName` (fixed: `"Agri Bhasha Samarthak"`), `issuedDate`, `contributionsCount`, `validationsCount`, `certificateUrl` (PDF), `thumbnailUrl`, `shareUrl` |
| `400` | Requirements not met — returns `error.code` (`REQUIREMENTS_NOT_MET`), `error.message`, `error.missingContributions`, `error.missingValidations` |

---

### `GET /certificates/{certificateId}/download`

Download the certificate as a print-ready PDF (includes name & achievement).

**Security:** Bearer token required

**Path parameters**

| Name | Type | Required | Example |
|---|---|---|---|
| `certificateId` | string | Yes | `"DIC-20250917-0123"` |

**Responses**

| Status | Content-Type | Description |
|---|---|---|
| `200` | `application/pdf` | Certificate PDF file (binary) |
| `404` | | Certificate not found |

---

### `GET /certificates/{certificateId}/preview`

Get a certificate preview image.

**Security:** Bearer token required

**Path parameters**

| Name | Type | Required |
|---|---|---|
| `certificateId` | string | Yes |

**Responses**

| Status | Content-Type | Description |
|---|---|---|
| `200` | `image/png` | Certificate preview image (binary) |

---

### `GET /certificates/{certificateId}`

Get detailed information about a specific certificate.

**Security:** Bearer token required

**Path parameters**

| Name | Type | Required |
|---|---|---|
| `certificateId` | string | Yes |

**Responses**

| Status | Description |
|---|---|
| `200` | Returns `certificateId`, `recipientName`, `badgeName`, `issuedDate`, `contributionsCount`, `validationsCount`, `certificateUrl`, `thumbnailUrl` |

---

## 8. Additional Modality Modules (Suno / Likho / Dekho)

The specification also defines three parallel endpoint groups — **Suno** ("listen"), **Likho** ("write"), and **Dekho** ("watch/see") — that mirror the core Contribution/Validation flow for other data-collection modalities. Each module follows the same shape (`instructions` → `help` → `queue` → `submit` → `skip` → `report` → `session-complete`, plus a `validation` sub-flow). Request/response schemas for these modules (e.g. `SunoQueueRequest`, `LikhoSubmitRequest`, `DekhoValidationCorrectionRequest`, `HTTPValidationError`) are **referenced in the spec but not defined** in its `components/schemas` section — see [Known Spec Issues](#11-known-spec-issues). Field-level detail is therefore not available; only the operation shapes below are documented from the spec as given.

### 8.1 Suno

| Method | Path | Summary | Request schema | Notes |
|---|---|---|---|---|
| GET | `/suno/instructions` | Instructions | — | |
| GET | `/suno/help` | Help Page | — | |
| POST | `/suno/queue` | Queue | `SunoQueueRequest` | schema not defined in spec |
| POST | `/suno/submit` | Submit | `SunoSubmitRequest` | schema not defined in spec |
| POST | `/suno/skip` | Skip | `SunoSkipRequest` | schema not defined in spec |
| POST | `/suno/report` | Report | `SunoReportRequest` | schema not defined in spec |
| POST | `/suno/session-complete` | Session Complete | generic object (`Payload`) | |
| GET | `/suno/test-speaker` | Test Speaker | — | |
| GET | `/suno/validation` | Validation Queue | — | query param `batch_size` (integer, default `5`) |
| POST | `/suno/validation/correct` | Validation Correct | `SunoValidationAcceptRequest` | schema not defined in spec |
| POST | `/suno/validation/reject` | Validation Reject | `SunoValidationRejectRequest` | schema not defined in spec |
| POST | `/suno/validation/submit-correction` | Validation Correction | `SunoValidationCorrectionRequest` | schema not defined in spec |
| POST | `/suno/validation/skip` | Validation Skip | `SunoSkipRequest` | schema not defined in spec |
| POST | `/suno/validation/report` | Validation Report | `SunoReportRequest` | schema not defined in spec |

All POST operations above return `200` on success and `422` (`HTTPValidationError` — not defined in spec) on validation failure.

### 8.2 Likho

| Method | Path | Summary | Request schema | Notes |
|---|---|---|---|---|
| GET | `/likho/instructions` | Instructions | — | |
| GET | `/likho/help` | Help Page | — | |
| POST | `/likho/queue` | Queue | `LikhoQueueRequest` | schema not defined in spec |
| POST | `/likho/submit` | Submit | `LikhoSubmitRequest` | schema not defined in spec |
| POST | `/likho/skip` | Skip | `LikhoSkipRequest` | schema not defined in spec |
| POST | `/likho/report` | Report | `LikhoReportRequest` | schema not defined in spec |
| POST | `/likho/session-complete` | Session Complete | generic object (`Payload`) | |
| GET | `/likho/validation` | Validation Queue | — | query param `batch_size` (integer, default `5`) |
| POST | `/likho/validation/correct` | Validation Correct | `LikhoValidationAcceptRequest` | schema not defined in spec |
| POST | `/likho/validation/reject` | Validation Reject | `LikhoValidationRejectRequest` | schema not defined in spec |
| POST | `/likho/validation/submit-correction` | Validation Correction | `LikhoValidationCorrectionRequest` | schema not defined in spec |
| POST | `/likho/validation/skip` | Validation Skip | `LikhoSkipRequest` | schema not defined in spec |
| POST | `/likho/validation/report` | Validation Report | `LikhoReportRequest` | schema not defined in spec |

All POST operations above return `200` on success and `422` (`HTTPValidationError` — not defined in spec) on validation failure. Note: Likho has no `test-speaker` equivalent endpoint in the spec (consistent with it being a text-based module).

### 8.3 Dekho

| Method | Path | Summary | Request schema | Notes |
|---|---|---|---|---|
| GET | `/dekho/instructions` | Instructions | — | |
| GET | `/dekho/help` | Help Page | — | |
| POST | `/dekho/queue` | Queue | `DekhoQueueRequest` | schema not defined in spec |
| POST | `/dekho/submit` | Submit | `DekhoSubmitRequest` | schema not defined in spec |
| POST | `/dekho/skip` | Skip | `DekhoSkipRequest` | schema not defined in spec |
| POST | `/dekho/report` | Report | `DekhoReportRequest` | schema not defined in spec |
| POST | `/dekho/session-complete` | Session Complete | generic object (`Payload`) | |
| GET | `/dekho/validation` | Validation Queue | — | query param `batch_size` (integer, default `5`) |
| POST | `/dekho/validation/correct` | Validation Correct | `DekhoValidationAcceptRequest` | schema not defined in spec |
| POST | `/dekho/validation/reject` | Validation Reject | `DekhoValidationRejectRequest` | schema not defined in spec |
| POST | `/dekho/validation/submit-correction` | Validation Correction | `DekhoValidationCorrectionRequest` | schema not defined in spec |
| POST | `/dekho/validation/skip` | Validation Skip | `DekhoSkipRequest` | schema not defined in spec |
| POST | `/dekho/validation/report` | Validation Report | `DekhoReportRequest` | schema not defined in spec |

All POST operations above return `200` on success and `422` (`HTTPValidationError` — not defined in spec) on validation failure.

---

## 9. Data Models (Schemas)

### `SystemConfig`

System configuration parameters that can be adjusted without code changes.

| Property | Type | Description |
|---|---|---|
| `certificateRequirements.contributionsRequired` | integer | Number of voice contributions required for certificate (e.g. `5`) |
| `certificateRequirements.validationsRequired` | integer | Number of validations required for certificate (e.g. `25`) |
| `certificateRequirements.certificateTitle` | string | Title of the certificate to be issued (e.g. `"Agri Bhasha Samarthak"`) |
| `sessionLimits.contributionsPerSession` | integer | Number of contributions per recording session (e.g. `5`) |
| `sessionLimits.validationsPerSession` | integer | Number of validations per validation session (e.g. `25`) |
| `timeouts.otpExpirySeconds` | integer | OTP validity period in seconds (e.g. `300`, 5 min) |
| `timeouts.tokenExpirySeconds` | integer | JWT token expiry in seconds (e.g. `86400`, 24h) |
| `timeouts.sessionTimeoutSeconds` | integer | Session timeout in seconds (e.g. `1800`, 30 min) |
| `timeouts.refreshTokenExpiryDays` | integer | Refresh token expiry in days (e.g. `30`) |
| `fileLimits.maxAudioSizeBytes` | integer | Maximum audio file size in bytes (e.g. `10485760`, 10MB) |
| `fileLimits.maxAudioDurationSeconds` | integer | Maximum audio duration in seconds (e.g. `300`, 5 min) |
| `fileLimits.allowedAudioFormats` | string[] | Allowed audio file formats, e.g. `["mp3", "wav", "m4a", "aac"]` |
| `validationRules.nameMinLength` | integer | Minimum length for user names (e.g. `2`) |
| `validationRules.nameMaxLength` | integer | Maximum length for user names (e.g. `50`) |
| `validationRules.mobileNumberPattern` | string | Regex pattern for Indian mobile numbers (`^[6-9]\d{9}$`) |
| `validationRules.otpPattern` | string | Regex pattern for OTP validation (`^\d{6}$`) |
| `contactInfo.supportEmail` | string | Support email address (e.g. `"voicegive.ai4x@gmail.com"`) |
| `contactInfo.supportPhone` | string | Support phone number (e.g. `"+91-11-12345678"`) |
| `contactInfo.website` | string | Official website URL (e.g. `"https://agridaan.gov.in"`) |
| `serverUrls.productionUrl` | string | Production server URL |
| `serverUrls.developmentUrl` | string | Development server URL |
| `serverUrls.stagingUrl` | string | Staging server URL |
| `rateLimits.otpRequestsPerHour` | integer | Max OTP requests per hour per mobile number (e.g. `5`) |
| `rateLimits.apiRequestsPerMinute` | integer | Max API requests per minute per user (e.g. `60`) |
| `rateLimits.fileUploadsPerHour` | integer | Max file uploads per hour per user (e.g. `20`) |
| `features.enableVoiceContributions` | boolean | Enable voice contributions |
| `features.enableAudioValidation` | boolean | Enable audio-text validation |
| `features.enableCertificateGeneration` | boolean | Enable certificate generation |
| `features.enableMultiLanguage` | boolean | Enable multi-language support |
| `features.enableLocationServices` | boolean | Enable location-based features |
| `lastUpdated` | string (date-time) | Timestamp when configuration was last updated |
| `version` | string | Configuration version |

### `User`

| Property | Type | Example |
|---|---|---|
| `userId` | string (uuid) | |
| `mobileNo` | string | `"+919177454678"` |
| `firstName` | string | |
| `lastName` | string | |
| `email` | string | |
| `createdAt` | string (date-time) | |

### `UserProfile`

| Property | Type | Example |
|---|---|---|
| `userId` | string (uuid) | |
| `firstName` | string | `"Ragani"` |
| `lastName` | string | `"Shukla"` |
| `mobileNo` | string | `"+919177454678"` |
| `email` | string | `"ragani.dibd@gmail.com"` |
| `ageGroup` | string | `"26-30 years"` |
| `gender` | string | `"Female"` |
| `country` | string | `"India"` |
| `state` | string | `"Maharashtra"` |
| `district` | string | `"Amravati"` |
| `preferredLanguageCode` | string | `"mr"` |
| `contributionCount` | integer | `5` |
| `validationCount` | integer | `25` |
| `certificateEarned` | boolean | |
| `certificateId` | string | |
| `consentGiven` | boolean | |
| `consentTimestamp` | string (date-time) | |
| `createdAt` | string (date-time) | |
| `updatedAt` | string (date-time) | |

### `ErrorResponse`

| Property | Type | Example |
|---|---|---|
| `success` | boolean | `false` |
| `error.code` | string | `"ERROR_CODE"` |
| `error.message` | string | `"Error message"` |
| `error.details` | object | |
| `error.timestamp` | string (date-time) | |

### Referenced but undefined schemas

The following schemas are referenced with `$ref` by the Suno/Likho/Dekho endpoints but have **no corresponding definition** under `components/schemas` in the source specification. Treat their exact field structure as unknown until the source spec is corrected:

`HTTPValidationError`, `SunoQueueRequest`, `SunoSubmitRequest`, `SunoValidationAcceptRequest`, `SunoValidationRejectRequest`, `SunoValidationCorrectionRequest`, `SunoReportRequest`, `LikhoQueueRequest`, `LikhoSubmitRequest`, `LikhoReportRequest`, `LikhoValidationAcceptRequest`, `LikhoValidationRejectRequest`, `LikhoValidationCorrectionRequest`, `DekhoQueueRequest`, `DekhoSubmitRequest`, `DekhoReportRequest`, `DekhoValidationAcceptRequest`, `DekhoValidationRejectRequest`, `DekhoValidationCorrectionRequest`. Note `SunoSkipRequest`, `LikhoSkipRequest`, and `DekhoSkipRequest` are also referenced and undefined.

---

## 10. Error Handling

Most error responses follow the shared `ErrorResponse` envelope:

```json
{
  "success": false,
  "error": {
    "code": "ERROR_CODE",
    "message": "Error message",
    "details": {},
    "timestamp": "2025-01-17T10:30:00Z"
  }
}
```

Common error codes observed in the spec:

| Code | Where | Meaning |
|---|---|---|
| `INVALID_MOBILE` | `POST /auth/send-otp` (400) | Invalid mobile number format |
| `USER_NOT_FOUND` | `POST /auth/send-otp` (404) | Mobile number not registered |
| `INVALID_OTP` | `POST /auth/verify-otp` (401) | OTP is incorrect |
| `CONSENT_REQUIRED` | `POST /auth/consent` (400) | Not all consents were accepted |
| `VALIDATION_ERROR` | `POST /users/register` (400) | One or more fields failed validation (see `validationErrors[]`) |
| `REQUIREMENTS_NOT_MET` | `POST /certificates/generate` (400) | Contribution/validation thresholds not yet met |

---

## 11. Known Spec Issues

These are structural/completeness issues found in the source `contribute_swagger.yaml` while producing this documentation; they are called out here rather than silently fixed, so the API owner can correct the source file:

1. **Misplaced path definitions:** The `/suno/*`, `/likho/*`, and `/dekho/*` path items are nested inside the top-level `components:` block (after `components.schemas`) rather than under the top-level `paths:` block. This is invalid per the OpenAPI 3.0.3 structure and most tooling (Swagger UI, codegen) will fail to parse or will silently ignore these operations. They should be moved under `paths:` alongside the other endpoint groups.
2. **Undefined schemas:** 19 schemas referenced via `$ref` (`HTTPValidationError` and the Suno/Likho/Dekho request bodies — see [Section 9](#referenced-but-undefined-schemas)) are never defined under `components/schemas`, so the request/response shapes for those 45 operations cannot be fully documented from the spec alone.
3. **No description/summary depth for Suno/Likho/Dekho:** Unlike the core Contribution/Validation/Certificate endpoints, these three modules have only a `summary` (e.g. "Queue", "Submit") and no `description`, so their exact business semantics (how they differ from the core Contribution/Validation flow) are not documented in the source spec.
4. **Single server entry:** Only a `development` server (`http://localhost:9000`) is declared; `SystemConfig.serverUrls` in the schema references production/staging/development URLs that are not reflected in the top-level `servers:` list.

---

## 12. Endpoint Index

| Method | Path | Tag | Summary |
|---|---|---|---|
| POST | `/auth/send-otp` | Authentication | Send OTP to mobile number |
| POST | `/auth/resend-otp` | Authentication | Resend OTP |
| POST | `/auth/verify-otp` | Authentication | Verify OTP and login |
| POST | `/auth/consent` | Authentication | Accept terms and conditions |
| POST | `/auth/logout` | Authentication | Logout user |
| POST | `/auth/refresh-token` | Authentication | Refresh access token |
| POST | `/users/register` | User Profile | Complete user registration |
| GET | `/users/profile` | User Profile | Get current user profile |
| PUT | `/users/profile` | User Profile | Update user profile |
| GET | `/users/stats` | User Profile | Get user contribution statistics |
| GET | `/location/countries` | Location | Get country list |
| GET | `/location/states` | Location | Get state list |
| GET | `/location/districts` | Location | Get district list |
| GET | `/system/languages` | System | Get supported languages |
| GET | `/system/test-speaker` | System | Get sample audio for speaker test |
| POST | `/system/test-microphone` | System | Test microphone quality |
| GET | `/system/health` | System | Health check endpoint |
| GET | `/system/version` | System | Get API version information |
| GET | `/system/config` | System | Get system configuration |
| POST | `/contributions/get-sentences` | Contribution | Get sentences for recording |
| POST | `/contributions/record` | Contribution | Submit audio recording |
| POST | `/contributions/skip` | Contribution | Skip a sentence |
| POST | `/contributions/report` | Contribution | Report issue with sentence |
| POST | `/contributions/session-complete` | Contribution | Complete contribution session |
| GET | `/validations/get-queue` | Validation | Get validation queue |
| POST | `/validations/submit` | Validation | Submit validation decision |
| POST | `/validations/session-complete` | Validation | Complete validation session |
| GET | `/certificates/check-eligibility` | Certificate | Check certificate eligibility |
| POST | `/certificates/generate` | Certificate | Generate certificate |
| GET | `/certificates/{certificateId}/download` | Certificate | Download certificate PDF |
| GET | `/certificates/{certificateId}/preview` | Certificate | Preview certificate |
| GET | `/certificates/{certificateId}` | Certificate | Get certificate details |
| GET/POST | `/suno/*` (13 operations) | suno | See [8.1 Suno](#81-suno) |
| GET/POST | `/likho/*` (13 operations) | likho | See [8.2 Likho](#82-likho) |
| GET/POST | `/dekho/*` (13 operations) | dekho | See [8.3 Dekho](#83-dekho) |

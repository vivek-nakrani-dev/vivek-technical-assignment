# 📝 Flutter Notes App

A simple Notes application built with **Flutter** and **Firebase**, supporting authentication and secure CRUD operations for user-specific notes.

---

## 🚀 Features

### 🔐 Authentication

* Email & password sign up
* Login & logout
* Persistent session (auto-login after app restart)

### 🗒️ Notes Management (CRUD)

Each note contains:

* `id`
* `title`
* `content`
* `created_at`
* `updated_at`
* `user_id`

Operations:

* Create note
* Read notes (list view)
* Update note
* Delete note

### 🔒 Security

* Each user can access **only their own notes**
* Firestore security rules enforce user-level isolation

### 🔎 Search

* Search notes by title
* Implemented using client-side filtering

---

## 🏗️ Tech Stack

* Flutter (UI)
* Firebase Authentication
* Cloud Firestore (database)
* Provider

---

## 📦 Project Setup

### 1. Clone the repository

```bash
git clone https://github.com/vivek-nakrani-dev/vivek-technical-assignment.git
cd vivek-technical-assignment
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Setup Firebase

1. Create a Firebase project at [https://console.firebase.google.com](https://console.firebase.google.com)
2. Enable:

    * Authentication → Email/Password
    * Firestore Database
3. Download configuration files:

    * `google-services.json` (Android)

4. Place them in:

    * `android/app/`

### 4. Run the app

```bash
flutter run
```

---

## 🗄️ Database Structure (Firestore)

### Collection: `notes`

```text
notes (collection)
 └── noteId (document)
      ├── id: string
      ├── title: string
      ├── content: string
      ├── user_id: string
      ├── created_at: timestamp
      ├── updated_at: timestamp
```

---

## 🔐 Firestore Security Rules

```js
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    match /NOTES/{noteId} {

      // READ: only user's own notes
      allow read: if request.auth != null
        && resource.data.USER_ID == request.auth.uid;

      // CREATE: must set USER_ID as current user
      allow create: if request.auth != null
        && request.resource.data.USER_ID == request.auth.uid

      // UPDATE: only owner can update AND cannot change ownership
      allow update: if request.auth != null
        && resource.data.USER_ID == request.auth.uid
        && request.resource.data.USER_ID == resource.data.USER_ID

      // DELETE: only owner can delete
      allow delete: if request.auth != null
        && resource.data.USER_ID == request.auth.uid;
    }
  }
}
```

---

## 🔑 Authentication Approach

* Firebase Authentication (Email/Password)
* `FirebaseAuth.instance.authStateChanges()` used for session persistence
* User session is automatically restored on app launch

---

## ⚖️ Assumptions & Trade-offs

* Search is implemented client-side for simplicity
* No pagination implemented for notes list
* Basic UI focused on functionality over design
* Firebase used as backend to speed up development

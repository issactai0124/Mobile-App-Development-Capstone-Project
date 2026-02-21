# User Stories & Design Requirements

## User Stories

### 1. Login & Registration
**As a** new user,
**I want to** register with my details (username, email, password),
**So that** I can access the app features.

**As a** returning user,
**I want to** log in with my credentials,
**So that** I can access my saved data.

**Acceptance Criteria:**
- User can enter username, email, password on registration.
- User can enter email and password on login.
- Error feedback is shown for empty fields or incorrect credentials.
- User data is persisted locally (auto-login on next session).

### 2. Home Page
**As a** logged-in user,
**I want to** see my progress and a welcome message,
**So that** I feel motivated.

**Acceptance Criteria:**
- Display "Welcome [User Name]".
- Show progress summary (e.g., "To Do", "Done").
- List active tasks/habits.

### 3. App Navigation (Menu)
**As a** user,
**I want to** navigate between different sections seamlessly,
**So that** I can easily access features.

**Acceptance Criteria:**
- Sidebar or Bottom Navigation Menu.
- Links to: Home, Habits, Personal Info, Report, Notification, Sign Out.

### 4. Detailed Task Screen
**As a** user,
**I want to** view details of a specific task,
**So that** I understand what needs to be done.

**Acceptance Criteria:**
- View task title, description, and status.
- Edit or delete the task.

### 5. Profile/Settings Page
**As a** user,
**I want to** view and update my personal information,
**So that** my profile is up to date.

**Acceptance Criteria:**
- Edit name, username, age, country.
- Save changes locally.

### 6. Task Management
**As a** user,
**I want to** add, move, and delete tasks,
**So that** I can manage my daily activities.

**Acceptance Criteria:**
- "Add Task" button.
- Delete task option.
- Mark task as completed.

### 7. Reports Page
**As a** user,
**I want to** view my daily/weekly progress,
**So that** I can track my habits.

**Acceptance Criteria:**
- Visual representation (e.g., table or chart) of completed vs pending tasks.
- History view.

### 8. Notifications/Reminders
**As a** user,
**I want to** customize task reminders,
**So that** I don't forget my tasks.

**Acceptance Criteria:**
- Enable/Disable notifications toggle.
- Set specific times for reminders.

### 9. Sharing
**As a** user,
**I want to** share my tasks/progress,
**So that** I can collaborate or show off to friends.

**Acceptance Criteria:**
- Share button functionality (invoking system share dialog).

## UX Wireframe Descriptions (Based on Attached Design)

### Login Screen
- Blue background.
- "Habitt" Logo/Title.
- Input: Username/Email.
- Input: Password.
- Buttons: "Log in", "Sign Up".
- "Forgot password?" link.

### Registration Screen
- Title: "Register".
- Back button.
- Inputs: Name, Username, Age (Slider), Country (Dropdown).
- Habit Selection: Chips (Wake Up Early, Workout, Drink Water, etc.).
- "Register" button at bottom.

### Home Screen
- Header: User Name.
- Section: "To Do" with list of pending habits.
- Section: "Done" with list of completed habits.
- Visual feedback (Green checkmarks, etc.).

### Menu (Drawer)
- User Profile Picture/Name.
- List: Habits, Personal Info, Report, Notification, Sign Out.

### Detailed/Configure Screen
- Edit Habit Name.
- Select Color/Category.
- "Add Habit" / "Save" button.

### Settings Screen
- Edit Profile fields (Name, Username, Age, Country).
- "Save Changes" button.

### Integrate API Screen (Country Selection?)
- List of countries/items fetched from external API.

### Notifications Screen
- Toggle: "Enable Notification".
- Time Picker: "From" - "To".
- "Save Changes" button.

### Report Screen
- Table/Grid view.
- Rows: Habits.
- Columns: Days (Mon, Tue, Wed).
- Status Icons: Check (Green), X (Red).

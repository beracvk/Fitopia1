# Fitopia 🌿
### AI-Assisted Nutrition and Fitness Mobile Application

Fitopia is a mobile application developed with Flutter and Firebase to support users in organizing their nutrition and fitness routines.

The project combines personalized user profiles, meal planning, exercise recommendations, and AI-assisted features in a single mobile application.

## Features

**User Authentication**
- Email-based registration and login using Firebase Authentication.
- Personal information collection during onboarding.

**Personalized User Experience**
- User profiles with personal information and fitness goals.
- Nutrition and activity-related information displayed through the application.

**AI-Assisted Meal Recommendations**
- Meal recommendation interface with food descriptions, portions, and calorie information.
- Gemini API integration for generating text-based recommendations.

**AI-Assisted Exercise Recommendations**
- Exercise recommendation interface with descriptions, difficulty levels, and exercise details.
- Exercise timer and AI-assisted recommendation functionality.

**Meal Planning**
- Daily meal planning interface.
- Breakfast, lunch, snack, and dinner sections.
- Calorie and macronutrient tracking interface.

## Technologies Used

- **Flutter** — Cross-platform mobile application development
- **Dart** — Programming language
- **Firebase Authentication** — User registration and login
- **Firebase** — Backend integration
- **Google Gemini API** — AI-assisted text generation
- **HTTP** — API requests
- **flutter_dotenv** — Environment-based configuration

## Application Screenshots

### Welcome Screen
![Welcome Screen](screenshots/Welcome%20Screen.png)

### Personal Information
![Personal Information](screenshots/Personal%20Information.png)

### AI Meal Recommendations
![AI Meal Recommendations](screenshots/AI%20Meal%20Recommendations.png)

### AI Exercise Recommendations
![AI Exercise Recommendations](screenshots/AI%20Exercise%20Recommendations.png)

### Meal Planning
![Meal Planning](screenshots/Meal%20Planning.png)

## Project Purpose

Fitopia was developed as a team project to explore mobile application development, Firebase integration, and the use of artificial intelligence in wellness-related applications.

The project provided hands-on experience in Flutter development, API integration, teamwork, and building user-focused application interfaces.

## Getting Started

1. Clone the repository.
2. Install Flutter and the required dependencies.
3. Run `flutter pub get`.
4. Configure the required Firebase settings.
5. Create a local `.env` file and configure the Gemini API key.
6. Run the application on a supported device or emulator.

**Environment configuration example:**

```env
GEMINI_API_KEY=YOUR_API_KEY
```

**Security Note:** Never commit real API keys or other sensitive credentials to a public repository. This project is intended for educational and demonstration purposes.

## Development

Developed collaboratively as a student software project.

**Repository:** https://github.com/beracvk/Fitopia1

## Disclaimer

Fitopia is an educational software project. Its nutrition and exercise content is for general informational purposes and is not a substitute for professional medical or dietary advice.
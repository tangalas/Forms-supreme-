<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SeeMe Rolling E-Bike Rental Agreement</title>
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/@emailjs/browser@3/dist/email.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
<!-- Same styles as before... -->
<style>
@font-face {
  font-family: 'Handwriting';
  src: url('https://fonts.gstatic.com/s/dancingscript/v24/If2cXTr6YS-zF4S-kcSWSVi_sxjsohD9F50Ruu7BMSo3ROp6.woff2') format('woff2');
  font-display: swap;
}

.font-handwriting {
  font-family: 'Handwriting', cursive;
}

.bg-emerald-300 {
  background-color: #6ee7b7;
}

.bg-emerald-400 {
  background-color: #34d399;
}

.bg-emerald-500 {
  background-color: #10b981;
}

.bg-emerald-600 {
  background-color: #059669;
}

.text-emerald-600 {
  color: #059669;
}

.bg-indigo-900 {
  background-color: #312e81;
}

.text-indigo-900 {
  color: #312e81;
}

.hover\:bg-indigo-800:hover {
  background-color: #3730a3;
}

.signature-pad {
  width: 100%;
  height: 160px;
  border: 1px solid #d1d5db;
  border-radius: 0.375rem;
  background-color: white;
  position: relative;
  overflow: hidden;
}

.signature-pad canvas {
  width: 100%;
  height: 100%;
  touch-action: none;
}

.signature-placeholder {
  position: absolute;
  inset: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #9ca3af;
  pointer-events: none;
}

.date-picker, .time-picker {
  position: relative;
}

.date-picker-content, .time-picker-content {
  display: none;
  position: absolute;
  top: 100%;
  left: 0;
  z-index: 50;
  background-color: white;
  border: 1px solid #d1d5db;
  border-radius: 0.375rem;
  box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
  padding: 0.5rem;
  margin-top: 0.25rem;
  width: 300px;
}

.time-picker-content {
  height: 240px;
  overflow-y: auto;
}

.calendar {
  display: grid;
  grid-template-columns: repeat(7, 1fr);
  gap: 0.25rem;
}

.calendar-header {
  grid-column: span 7;
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 0.5rem;
}

.calendar-day {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 2rem;
  width: 2rem;
  border-radius: 9999px;
  cursor: pointer;
}

.calendar-day:hover {
  background-color: #f3f4f6;
}

.calendar-day.selected {
  background-color: #10b981;
  color: white;
}

.calendar-day.disabled {
  color: #d1d5db;
  cursor: not-allowed;
}

.time-option {
  padding: 0.5rem 1rem;
  cursor: pointer;
  border-radius: 0.375rem;
}

.time-option:hover {
  background-color: #f3f4f6;
}

.time-option.selected {
  background-color: #d1fae5;
  font-weight: 500;
}

.error-border {
  border: 2px solid #ef4444;
}

.hidden {
  display: none;
}

.show {
  display: block;
}

.language-dropdown {
  position: absolute;
  right: 0;
  top: 100%;
  margin-top: 0.25rem;
  width: 10rem;
  background-color: white;
  box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
  border-radius: 0.375rem;
  z-index: 10;
  display: none;
}

.language-dropdown.show {
  display: block;
}

.radio-group {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
}

.radio-item {
  width: 2.5rem;
  height: 2.5rem;
  border-radius: 9999px;
  background-color: white;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
}

.radio-item:hover {
  background-color: #f3f4f6;
}

.radio-item.selected {
  background-color: #059669;
  color: white;
}

.file-upload {
  border: 1px dashed #d1d5db;
  border-radius: 0.375rem;
  padding: 1.5rem;
  background-color: white;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  cursor: pointer;
}

.file-upload.error {
  border-color: #ef4444;
}

.image-preview {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 0.5rem;
  margin-top: 1rem;
}

.image-preview-item {
  position: relative;
  height: 6rem;
}

.image-preview-item img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  border-radius: 0.375rem;
}

.image-preview-item button {
  position: absolute;
  top: -0.5rem;
  right: -0.5rem;
  background-color: #ef4444;
  color: white;
  border-radius: 9999px;
  padding: 0.25rem;
  border: none;
  cursor: pointer;
}

.terms-container {
  max-height: 300px;
  overflow-y: auto;
  padding: 1rem;
  background-color: rgba(255, 255, 255, 0.7);
  border-radius: 0.375rem;
  margin-bottom: 1rem;
}

.success-screen {
  display: none;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  text-align: center;
  padding: 2rem;
  background-color: #10b981;
  border-radius: 0.5rem;
  box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
}

.success-screen.show {
  display: flex;
}

.loading-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  z-index: 100;
  display: none;
}

.loading-spinner {
  border: 4px solid rgba(255, 255, 255, 0.3);
  border-radius: 50%;
  border-top: 4px solid white;
  width: 40px;
  height: 40px;
  animation: spin 1s linear infinite;
}

.loading-message {
  color: white;
  margin-top: 10px;
  font-weight: bold;
}

.error-message {
  background-color: #fee2e2;
  border: 1px solid #ef4444;
  color: #b91c1c;
  padding: 10px;
  border-radius: 5px;
  margin-bottom: 15px;
  display: none;
}

.debug-panel {
  position: fixed;
  bottom: 0;
  right: 0;
  background-color: rgba(0, 0, 0, 0.8);
  color: #00ff00;
  font-family: monospace;
  padding: 10px;
  max-width: 400px;
  max-height: 200px;
  overflow-y: auto;
  z-index: 9999;
  font-size: 12px;
  display: none;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
</style>
</head>
<body class="bg-teal-300/70 min-h-screen flex items-center justify-center p-4">
<div class="w-full max-w-3xl">
<!-- Debug Panel -->
<div id="debug-panel" class="debug-panel"></div>

<!-- Loading Overlay -->
<div id="loading-overlay" class="loading-overlay">
  <div class="loading-spinner"></div>
  <p class="text-white mt-4">Processing your submission...</p>
</div>

<!-- Success Screen -->
<div id="success-screen" class="success-screen">
  <div class="mb-6">
    <img src="https://hebbkx1anhila5yf.public.blob.vercel-storage.com/Est.%202023%20-%201-cqyFsv1on4rowqkbTjcL7L2CwzbvFT.png" alt="SeeMe Rolling E-Bike Rentals Logo" width="150" height="150" class="rounded-md">
  </div>
  <h1 class="text-3xl font-bold text-white mb-4 font-handwriting" data-translate="thankYou">Thank You For Your Submission!</h1>
  <p class="text-white mb-6" data-translate="confirmationSent">A confirmation has been sent to your email address.</p>
  <button id="new-form-button" class="px-4 py-2 bg-indigo-900 hover:bg-indigo-800 text-white rounded-md" data-translate="newForm">Submit Another Form</button>
</div>

<div id="form-container" class="bg-emerald-500 rounded-lg shadow-md overflow-hidden">
  <!-- Error Message Banner -->
  <div id="error-message" class="error-message mx-6 mt-6">
    <div class="flex">
      <svg class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"/>
      </svg>
      <div>
        <p class="font-bold">Submission Error</p>
        <p class="text-sm" id="error-details">There was an error processing your form. Please try again.</p>
      </div>
    </div>
  </div>

  <!-- Header -->
  <div class="flex justify-end pb-0 pt-4 px-4 relative">
    <button id="language-button" class="h-8 px-2 text-sm text-white flex items-center gap-1">
      <span class="text-xs">🇺🇸</span> <span id="current-language">English (US)</span>
      <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="h-4 w-4">
        <path d="m6 9 6 6 6-6"/>
      </svg>
    </button>
    <div id="language-dropdown" class="language-dropdown">
      <div class="py-1">
        <button class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 w-full text-left" data-language="English (US)" data-lang-code="en">
          <span class="text-xs mr-2">🇺🇸</span> English (US)
        </button>
        <button class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 w-full text-left" data-language="Ελληνικά" data-lang-code="el">
          <span class="text-xs mr-2">🇬🇷</span> Ελληνικά
        </button>
      </div>
    </div>
  </div>

  <!-- Logo and Title -->
  <div class="px-6 py-4 flex flex-col items-center">
    <div class="mb-6">
      <img src="https://hebbkx1anhila5yf.public.blob.vercel-storage.com/Est.%202023%20-%201-cqyFsv1on4rowqkbTjcL7L2CwzbvFT.png" alt="SeeMe Rolling E-Bike Rentals Logo" width="150" height="150" class="rounded-md">
    </div>
    <h1 class="text-2xl font-bold text-indigo-900 mb-8 font-handwriting text-center" data-translate="formTitle">
      SeeMe Rolling E-Bike Rental Agreement
    </h1>
  </div>

  <!-- Form -->
  <div class="bg-emerald-400 p-6">
    <form id="rental-form" class="space-y-6">
      <!-- Renter Information -->
      <div class="p-4 bg-emerald-300 rounded-md">
        <h3 class="text-lg font-medium text-indigo-900 mb-4" data-translate="renterInfo">Renter Information</h3>
        <div class="space-y-4">
          <!-- Name Fields -->
          <div class="grid grid-cols-1 md:grid-cols-3 gap-2">
            <div>
              <label for="first-name" class="text-sm font-medium text-indigo-900 flex items-center">
                <span data-translate="firstName">First Name</span> <span class="text-red-500 ml-1">*</span>
              </label>
              <input
                id="first-name"
                name="participant-1-first-name"
                placeholder="First Name"
                class="w-full mt-1 px-3 py-2 bg-white border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
                data-translate-placeholder="firstName"
                value="John" <!-- Pre-filled for testing -->
              >
              <p id="first-name-error" class="text-xs text-red-500 mt-1 hidden">
                <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="inline mr-1">
                  <circle cx="12" cy="12" r="10"/>
                  <line x1="12" y1="8" x2="12" y2="12"/>
                  <line x1="12" y1="16" x2="12.01" y2="16"/>
                </svg>
                <span data-translate="firstNameRequired">First name is required</span>
              </p>
            </div>
            <div>
              <label for="middle-name" class="text-sm font-medium text-indigo-900">
                <span data-translate="middleName">Middle Name</span>
              </label>
              <input
                id="middle-name"
                name="participant-1-middle-name"
                placeholder="Middle Name"
                class="w-full mt-1 px-3 py-2 bg-white border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
                data-translate-placeholder="middleName"
              >
            </div>
            <div>
              <label for="last-name" class="text-sm font-medium text-indigo-900 flex items-center">
                <span data-translate="lastName">Last Name</span> <span class="text-red-500 ml-1">*</span>
              </label>
              <input
                id="last-name"
                name="participant-1-last-name"
                placeholder="Last Name"
                class="w-full mt-1 px-3 py-2 bg-white border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
                data-translate-placeholder="lastName"
                value="Doe" <!-- Pre-filled for testing -->
              >
              <p id="last-name-error" class="text-xs text-red-500 mt-1 hidden">
                <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="inline mr-1">
                  <circle cx="12" cy="12" r="10"/>
                  <line x1="12" y1="8" x2="12" y2="12"/>
                  <line x1="12" y1="16" x2="12.01" y2="16"/>
                </svg>
                <span data-translate="lastNameRequired">Last name is required</span>
              </p>
            </div>
          </div>

          <!-- Nationality -->
          <div>
            <label for="nationality" class="text-sm font-medium text-indigo-900 flex items-center">
              <span data-translate="nationality">Nationality</span> <span class="text-red-500 ml-1">*</span>
            </label>
            <input
              id="nationality"
              name="participant-1-nationality"
              placeholder="Nationality"
              class="w-full mt-1 px-3 py-2 bg-white border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
              data-translate-placeholder="nationality"
              value="American" <!-- Pre-filled for testing -->
            >
            <p id="nationality-error" class="text-xs text-red-500 mt-1 hidden">
              <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="inline mr-1">
                <circle cx="12" cy="12" r="10"/>
                <line x1="12" y1="8" x2="12" y2="12"/>
                <line x1="12" y1="16" x2="12.01" y2="16"/>
              </svg>
              <span data-translate="nationalityRequired">Nationality is required</span>
            </p>
          </div>

          <!-- Email -->
          <div>
            <label for="email" class="text-sm font-medium text-indigo-900 flex items-center">
              <span data-translate="email">Email</span> <span class="text-red-500 ml-1">*</span>
            </label>
            <input
              id="email"
              name="participant-1-email"
              type="email"
              placeholder="example@example.com"
              class="w-full mt-1 px-3 py-2 bg-white border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
              value="test@example.com" <!-- Pre-filled for testing -->
            >
            <p id="email-error" class="text-xs text-red-500 mt-1 hidden">
              <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="inline mr-1">
                <circle cx="12" cy="12" r="10"/>
                <line x1="12" y1="8" x2="12" y2="12"/>
                <line x1="12" y1="16" x2="12.01" y2="16"/>
              </svg>
              <span data-translate="emailRequired">Please enter a valid email address</span>
            </p>
          </div>

          <!-- Phone Number -->
          <div>
            <label for="phone" class="text-sm font-medium text-indigo-900 flex items-center">
              <span data-translate="phoneNumber">Phone Number</span> <span class="text-red-500 ml-1">*</span>
            </label>
            <div class="grid grid-cols-4 gap-2 mt-1">
              <div class="col-span-1">
                <input
                  id="country-code"
                  name="participant-1-country-code"
                  placeholder="+1"
                  class="w-full px-3 py-2 bg-white border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
                  value="+1" <!-- Pre-filled for testing -->
                >
                <p class="text-xs text-indigo-900/80 mt-1" data-translate="countryCode">Country Code</p>
              </div>
              <div class="col-span-3">
                <input
                  id="phone"
                  name="participant-1-phone"
                  placeholder="Phone Number"
                  class="w-full px-3 py-2 bg-white border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
                  data-translate-placeholder="phoneNumber"
                  value="5555555555" <!-- Pre-filled for testing -->
                >
                <p class="text-xs text-indigo-900/80 mt-1" data-translate="phoneNumber">Phone Number</p>
                <p id="phone-error" class="text-xs text-red-500 mt-1 hidden">
                  <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="inline mr-1">
                    <circle cx="12" cy="12" r="10"/>
                    <line x1="12" y1="8" x2="12" y2="12"/>
                    <line x1="12" y1="16" x2="12.01" y2="16"/>
                  </svg>
                  <span data-translate="phoneRequired">Phone number is required</span>
                </p>
              </div>
            </div>
          </div>

          <!-- Type of Vehicle -->
          <div>
            <label class="text-sm font-medium text-indigo-900 flex items-center">
              <span data-translate="vehicleType">Type of Vehicle</span> <span class="text-red-500 ml-1">*</span>
            </label>
            <div id="vehicle-type-container" class="space-y-2 mt-2">
              <div class="flex items-center space-x-2">
                <input type="checkbox" id="e-scooter" name="participant-1-vehicle-type" value="e-scooter" class="h-4 w-4 text-emerald-600 focus:ring-emerald-500 border-gray-300 rounded" checked> <!-- Pre-checked for testing -->
                <label for="e-scooter" class="text-indigo-900" data-translate="eScooter">E- Scooter</label>
              </div>
              <div class="flex items-center space-x-2">
                <input type="checkbox" id="mountain-e-bike" name="participant-1-vehicle-type" value="mountain-e-bike" class="h-4 w-4 text-emerald-600 focus:ring-emerald-500 border-gray-300 rounded">
                <label for="mountain-e-bike" class="text-indigo-900" data-translate="mountainEBike">Mountain E- Bike</label>
              </div>
              <div class="flex items-center space-x-2">
                <input type="checkbox" id="trekking-e-bike" name="participant-1-vehicle-type" value="trekking-e-bike" class="h-4 w-4 text-emerald-600 focus:ring-emerald-500 border-gray-300 rounded">
                <label for="trekking-e-bike" class="text-indigo-900" data-translate="trekkingEBike">Trekking E-bike</label>
              </div>
              <div class="flex items-center space-x-2">
                <input type="checkbox" id="fat-tire-e-bike" name="participant-1-vehicle-type" value="fat-tire-e-bike" class="h-4 w-4 text-emerald-600 focus:ring-emerald-500 border-gray-300 rounded">
                <label for="fat-tire-e-bike" class="text-indigo-900" data-translate="fatTireEBike">Fat Tire E-bike</label>
              </div>
            </div>
            <p id="vehicle-type-error" class="text-xs text-red-500 mt-1 hidden">
              <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="inline mr-1">
                <circle cx="12" cy="12" r="10"/>
                <line x1="12" y1="8" x2="12" y2="12"/>
                <line x1="12" y1="16" x2="12.01" y2="16"/>
              </svg>
              <span data-translate="vehicleTypeRequired">Please select at least one vehicle type</span>
            </p>
          </div>

          <!-- Passport/ID/Driver's License -->
          <div>
            <label for="passport" class="text-sm font-medium text-indigo-900 flex items-center">
              <span data-translate="idDocument">Passport/ ID / DRIVER'S LICENSE</span> <span class="text-red-500 ml-1">*</span>
            </label>
            <div id="passport-upload" class="file-upload mt-2">
              <input type="file" id="passport" name="participant-1-passport" class="hidden">
              <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="#9ca3af" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="mb-2">
                <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/>
                <polyline points="17 8 12 3 7 8"/>
                <line x1="12" y1="3" x2="12" y2="15"/>
              </svg>
              <p class="text-base font-medium text-gray-500" data-translate="browseFiles">Browse Files</p>
              <p class="text-sm text-gray-400 mt-1" data-translate="dragAndDrop">Drag and drop files here</p>
            </div>
            <p id="passport-success" class="text-xs text-green-600 mt-1 hidden" data-translate="fileUploaded">File uploaded successfully</p>
            <p id="passport-error" class="text-xs text-red-500 mt-1 hidden">
              <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="inline mr-1">
                <circle cx="12" cy="12" r="10"/>
                <line x1="12" y1="8" x2="12" y2="12"/>
                <line x1="12" y1="16" x2="12.01" y2="16"/>
              </svg>
              <span data-translate="idRequired">ID document is required</span>
            </p>
          </div>
        </div>
      </div>

      <hr class="border-white/30 my-6">

      <!-- From Date and Time -->
      <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div>
          <label for="from-date" class="text-sm font-medium text-indigo-900 flex items-center">
            <span data-translate="from">From</span> <span class="text-red-500 ml-1">*</span>
          </label>
          <div class="date-picker mt-2">
            <button type="button" id="from-date-button" class="w-full px-3 py-2 bg-white border border-gray-300 rounded-md shadow-sm text-left flex items-center">
              <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="mr-2">
                <rect x="3" y="4" width="18" height="18" rx="2" ry="2"/>
                <line x1="16" y1="2" x2="16" y2="6"/>
                <line x1="8" y1="2" x2="8" y2="6"/>
                <line x1="3" y1="10" x2="21" y2="10"/>
              </svg>
              <span id="from-date-text" class="text-gray-500" data-translate="selectDate">Select date</span>
            </button>
            <div id="from-date-content" class="date-picker-content">
              <div class="calendar-header">
                <button type="button" id="prev-month" class="p-1">
                  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <polyline points="15 18 9 12 15 6"/>
                  </svg>
                </button>
                <div id="current-month-year">March 2025</div>
                <button type="button" id="next-month" class="p-1">
                  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <polyline points="9 18 15 12 9 6"/>
                  </svg>
                </button>
              </div>
              <div class="calendar" id="calendar-days">
                <!-- Calendar days will be inserted here by JavaScript -->
              </div>
            </div>
            <input type="hidden" id="from-date" name="from-date" value="2025-03-20"> <!-- Pre-filled for testing -->
            <p class="text-xs text-indigo-900/80 mt-1" data-translate="date">Date</p>
            <p id="from-date-error" class="text-xs text-red-500 mt-1 hidden">
              <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="inline mr-1">
                <circle cx="12" cy="12" r="10"/>
                <line x1="12" y1="8" x2="12" y2="12"/>
                <line x1="12" y1="16" x2="12.01" y2="16"/>
              </svg>
              <span data-translate="fromDateRequired">From date is required</span>
            </p>
          </div>
        </div>
        <div>
          <label for="from-time" class="text-sm font-medium text-indigo-900 flex items-center">
            <span data-translate="time">Time</span> <span class="text-red-500 ml-1">*</span>
          </label>
          <div class="time-picker mt-2">
            <button type="button" id="from-time-button" class="w-full px-3 py-2 bg-white border border-gray-300 rounded-md shadow-sm text-left flex items-center">
              <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="mr-2">
                <circle cx="12" cy="12" r="10"/>
                <polyline points="12 6 12 12 16 14"/>
              </svg>
              <span id="from-time-text" class="text-gray-500" data-translate="selectTime">Select time</span>
            </button>
            <div id="from-time-content" class="time-picker-content">
              <!-- Time options will be inserted here by JavaScript -->
            </div>
            <input type="hidden" id="from-time" name="from-time" value="10:00"> <!-- Pre-filled for testing -->
            <p class="text-xs text-indigo-900/80 mt-1" data-translate="hourMinutes">Hour Minutes</p>
            <p id="from-time-error" class="text-xs text-red-500 mt-1 hidden">
              <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="inline mr-1">
                <circle cx="12" cy="12" r="10"/>
                <line x1="12" y1="8" x2="12" y2="12"/>
                <line x1="12" y1="16" x2="12.01" y2="16"/>
              </svg>
              <span data-translate="fromTimeRequired">From time is required</span>
            </p>
          </div>
        </div>
      </div>

      <!-- Until Date and Time -->
      <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div>
          <label for="until-date" class="text-sm font-medium text-indigo-900">
            <span data-translate="until">Until</span>
          </label>
          <div class="date-picker mt-2">
            <button type="button" id="until-date-button" class="w-full px-3 py-2 bg-white border border-gray-300 rounded-md shadow-sm text-left flex items-center">
              <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="mr-2">
                <rect x="3" y="4" width="18" height="18" rx="2" ry="2"/>
                <line x1="16" y1="2" x2="16" y2="6"/>
                <line x1="8" y1="2" x2="8" y2="6"/>
                <line x1="3" y1="10" x2="21" y2="10"/>
              </svg>
              <span id="until-date-text" class="text-gray-500" data-translate="selectDate">Select date</span>
            </button>
            <div id="until-date-content" class="date-picker-content">
              <div class="calendar-header">
                <button type="button" id="until-prev-month" class="p-1">
                  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <polyline points="15 18 9 12 15 6"/>
                  </svg>
                </button>
                <div id="until-current-month-year">March 2025</div>
                <button type="button" id="until-next-month" class="p-1">
                  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <polyline points="9 18 15 12 9 6"/>
                  </svg>
                </button>
              </div>
              <div class="calendar" id="until-calendar-days">
                <!-- Calendar days will be inserted here by JavaScript -->
              </div>
            </div>
            <input type="hidden" id="until-date" name="until-date" value="2025-03-21"> <!-- Pre-filled for testing -->
            <p class="text-xs text-indigo-900/80 mt-1" data-translate="date">Date</p>
          </div>
        </div>
        <div>
          <label for="until-time" class="text-sm font-medium text-indigo-900">
            <span data-translate="time">Time</span>
          </label>
          <div class="time-picker mt-2">
            <button type="button" id="until-time-button" class="w-full px-3 py-2 bg-white border border-gray-300 rounded-md shadow-sm text-left flex items-center">
              <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="mr-2">
                <circle cx="12" cy="12" r="10"/>
                <polyline points="12 6 12 12 16 14"/>
              </svg>
              <span id="until-time-text" class="text-gray-500" data-translate="selectTime">Select time</span>
            </button>
            <div id="until-time-content" class="time-picker-content">
              <!-- Time options will be inserted here by JavaScript -->
            </div>
            <input type="hidden" id="until-time" name="until-time" value="10:00"> <!-- Pre-filled for testing -->
            <p class="text-xs text-indigo-900/80 mt-1" data-translate="hourMinutes">Hour Minutes</p>
          </div>
        </div>
      </div>

      <!-- Form validation error summary -->
      <div id="form-error-summary" class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded relative hidden" role="alert">
        <div class="flex">
          <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="mr-2">
            <circle cx="12" cy="12" r="10"/>
            <line x1="12" y1="8" x2="12" y2="12"/>
            <line x1="12" y1="16" x2="12.01" y2="16"/>
          </svg>
          <span data-translate="formErrorSummary">Please correct the errors in the form before submitting.</span>
        </div>
      </div>

      <div class="flex justify-end mt-8">
        <button type="submit" id="submit-button" class="px-4 py-2 bg-indigo-900 hover:bg-indigo-800 text-white rounded-md" data-translate="submit">
          Submit
        </button>
      </div>
    </form>
  </div>
</div>
</div>

<script>
// Initialize EmailJS
(function() {
  emailjs.init("NvSk02WM2n_leHENI"); // Using the actual EmailJS public key from the provided code
})();

// Safety timeout to ensure loading overlay is never stuck
window.addEventListener('load', function() {
  // If loading overlay gets stuck for more than 30 seconds, force hide it
  window.addEventListener('submit', function() {
    setTimeout(function() {
      const loadingOverlay = document.getElementById('loading-overlay');
      if (loadingOverlay && loadingOverlay.style.display === 'flex') {
        console.log('Safety timeout: hiding loading overlay');
        loadingOverlay.style.display = 'none';
        alert('The operation is taking longer than expected. Please try again.');
      }
    }, 30000);
  });
});

// Wait for DOM to be fully loaded before initializing JavaScript
document.addEventListener('DOMContentLoaded', function() {
  console.log('DOM fully loaded, initializing form functionality');

  // Elements
  const loadingOverlay = document.getElementById('loading-overlay');
  const loadingMessage = document.getElementById('loading-message');
  const errorMessage = document.getElementById('error-message');
  const errorDetails = document.getElementById('error-details');
  const submitButton = document.getElementById('submit-button');
  const form = document.getElementById('rental-form');
  const formContainer = document.getElementById('form-container');
  const successScreen = document.getElementById('success-screen');
  const formErrorSummary = document.getElementById('form-error-summary');
  const debugPanel = document.getElementById('debug-panel');

  // Display an error message
  function showError(message) {
    errorDetails.textContent = message || "There was an error processing your form. Please try again.";
    errorMessage.style.display = "block";
    loadingOverlay.style.display = "none";
    window.scrollTo({ top: 0, behavior: 'smooth' });
    console.log("Error displayed:", message);
  }

  // Hide error message
  function hideError() {
    errorMessage.style.display = "none";
    console.log("Error message hidden");
  }

  // Form submission with direct EmailJS and Google Drive integration
  form.addEventListener('submit', async function(e) {
  e.preventDefault();
  console.log('Form submitted');
  
  // Show loading overlay
  loadingOverlay.style.display = 'flex';
  
  try {
    // Get form data
    const firstName = document.getElementById('first-name').value || 'User';
    const email = document.getElementById('email').value || 'test@example.com';
    
    // Create a simplified version of the form for PDF generation
    const pdfElement = document.createElement('div');
    pdfElement.innerHTML = `
      <div style="padding: 20px; font-family: Arial, sans-serif;">
        <h1>E-Bike Rental Agreement</h1>
        <p><strong>Name:</strong> ${firstName}</p>
        <p><strong>Email:</strong> ${email}</p>
        <p><strong>Date:</strong> ${new Date().toLocaleDateString()}</p>
      </div>
    `;
    
    // Generate PDF
    const pdfBlob = await html2pdf()
      .from(pdfElement)
      .outputPdf('blob');
    
    // Create FormData for Google Drive upload
    const formData = new FormData();
    formData.append("pdfFile", pdfBlob, "rental_agreement.pdf");
    formData.append("email", email);
    
    // Send email via EmailJS
    await emailjs.send("service_fhedb8g", "template_a9vxnrs", {
      user_email: email
    }, "NvSk02WM2n_leHENI");
    
    // Save to Google Drive
    await fetch("https://script.google.com/macros/s/AKfycbx6iFHaDai58eJFeUTvF_nQEI96Ydywd7dUURi1vtbGrbjS4pxlU4nZ2JwdLcDVeJxg/exec", {
      method: "POST",
      body: formData
    });
    
    // Hide loading overlay
    loadingOverlay.style.display = 'none';
    
    // Show success screen
    formContainer.style.display = 'none';
    successScreen.classList.add('show');
    
  } catch (error) {
    console.error("Form submission error:", error);
    // Make sure to hide loading overlay even if there's an error
    loadingOverlay.style.display = 'none';
    alert("There was an error processing your form. Please try again.");
  }
});

  // Setup "Submit Another Form" button
  document.getElementById('new-form-button').addEventListener('click', function() {
    console.log("New form button clicked");
    form.reset();
    formContainer.style.display = 'block';
    successScreen.classList.remove('show');
    hideError();
  });

  console.log('Form initialization complete');
});
</script>
</body>
</html>


module.exports = {
    content: [
      "./views/**/*.ejs",
      "./public/**/*.html",
      "./public/**/*.js"
    ],
    theme: {
      extend: {
        colors: {
          'dark-background': '#121212',  // Dark background color
          'dark-card': '#1E1E1E',         // Card background color
          'instagram-pink': '#E1306C',    // Instagram's pink
          'instagram-purple': '#9B3D96',  // Instagram's purple
          'instagram-blue': '#5C6BC0',    // Instagram's blue
          'white': '#FFFFFF',             // White for text/buttons
        },
        fontFamily: {
          'apple-sf': ['-apple-system', 'BlinkMacSystemFont', 'sans-serif'],  // Apple-like font
        },
      },
    },
    plugins: [],
  }
  
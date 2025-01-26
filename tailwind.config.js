/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './pages/**/*.{js,ts,jsx,tsx,mdx}',
    './components/**/*.{js,ts,jsx,tsx,mdx}',
    './app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  darkMode: 'class',
  theme: {
    extend: {
      colors: {
        spirit: {
          // Dark mode colors
          darkBg: '#00242E',
          accent: '#2FF7FA',
          muted: '#14474E',
          border: '#004D59',
          // Light mode colors
          lightBg: '#FFFFFF',
          darkText: '#00242E',
          lightMuted: '#E6F9FA',
          lightBorder: '#B8ECEE',
        }
      },
      fontFamily: {
        sans: ['Poppins', 'sans-serif'],
      },
      backdropFilter: {
        'none': 'none',
        'blur': 'blur(20px)',
      },
      typography: {
        DEFAULT: {
          css: {
            maxWidth: 'none',
            color: 'inherit',
            a: {
              color: '#2FF7FA',
              '&:hover': {
                color: '#2FF7FA',
                opacity: 0.8,
              },
            },
            strong: {
              color: '#2FF7FA',
              fontWeight: '600',
            },
            h1: {
              color: 'inherit',
              fontWeight: '700',
            },
            h2: {
              color: 'inherit',
              fontWeight: '600',
            },
            h3: {
              color: 'inherit',
              fontWeight: '600',
            },
            h4: {
              color: 'inherit',
              fontWeight: '600',
            },
            code: {
              color: '#2FF7FA',
              backgroundColor: 'rgba(47, 247, 250, 0.1)',
              borderRadius: '0.25rem',
              padding: '0.25rem',
            },
            'code::before': {
              content: '""',
            },
            'code::after': {
              content: '""',
            },
            pre: {
              backgroundColor: 'rgba(47, 247, 250, 0.1)',
              color: 'inherit',
              borderRadius: '0.5rem',
              padding: '1rem',
            },
            blockquote: {
              color: 'inherit',
              borderLeftColor: '#2FF7FA',
            },
          },
        },
      },
    },
  },
  plugins: [
    require('@tailwindcss/typography'),
  ],
}


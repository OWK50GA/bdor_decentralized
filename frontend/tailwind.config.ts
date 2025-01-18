import type { Config } from "tailwindcss";

export default {
  content: [
    "./src/pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/components/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {
      colors: {
        background: "var(--background)",
        foreground: "var(--foreground)",
        gold: {
          100: '#F8E231',
          200: '#F2C464',
          300: '#F5D072',
          400: '#F0B752',
          500: '#FFD700',
          600: '#FFC400',
          700: '#FFB300',
          800: '#FFA000',
          900: '#FF8F00',
        }
      },
      boxShadow: {
        'gold': '0px 0px 5px #FFD700',
        'gold-hover': '0px 0px 13px #FFC400',
        'white': '0px 0px 10px #FFFFFF'
      }
    },
  },
  plugins: [],
} satisfies Config;

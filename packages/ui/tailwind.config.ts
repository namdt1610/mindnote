import { type Config } from 'tailwindcss'
import fontFamily from 'tailwindcss/defaultTheme'

/** @type {import('tailwindcss').Config} */
export default {
    content: [
        './app/**/*.{ts,tsx}',
        './pages/**/*.{ts,tsx}',
        './components/**/*.{ts,tsx}',
        '../../packages/ui/src/**/*.{ts,tsx}',
        './**/*.{ts,tsx}',
    ],
    theme: {
        extend: {
            keyframes: {
                gradient: {
                    '0%': { backgroundPosition: '0% 50%' },
                    '50%': { backgroundPosition: '100% 50%' },
                    '100%': { backgroundPosition: '0% 50%' },
                },
            },
            animation: {
                gradient: 'gradient 8s linear infinite',
            },
        },
    },
    plugins: [require('tailwindcss-animate')],
}

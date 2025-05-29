import baseConfig from '../../packages/ui/tailwind.config'

/** @type {import('tailwindcss').Config} */
export default {
    ...baseConfig,
    content: [
        './app/**/*.{ts,tsx}',
        './pages/**/*.{ts,tsx}',
        './components/**/*.{ts,tsx}',
        '../../packages/ui/src/**/*.{ts,tsx}',
        './**/*.{ts,tsx}',
    ],
}

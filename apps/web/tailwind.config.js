import baseConfig from '@workspace/ui/tailwind.config'

/** @type {import('tailwindcss').Config} */
export default {
    ...baseConfig,
    content: [
        './app/**/*.{js,ts,jsx,tsx,mdx}',
        './src/**/*.{js,ts,jsx,tsx,mdx}',
        '../../packages/ui/src/**/*.{js,ts,jsx,tsx}',
    ],
}

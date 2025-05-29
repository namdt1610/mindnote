import { type Config } from 'tailwindcss'
import animatePlugin from 'tailwindcss-animate'

export default {
    content: [
        './src/**/*.{ts,tsx}', // Nội bộ package UI
        '../../apps/web/**/*.{ts,tsx}', // App sử dụng nó
    ],
    theme: {
        extend: {},
    },
    plugins: [animatePlugin],
} satisfies Config

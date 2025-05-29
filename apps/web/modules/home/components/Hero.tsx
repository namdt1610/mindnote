'use client'
import GradientText from '@/components/GradientText'
import { Button } from 'ui'

export const Hero = () => {
    return (
        <>
            <GradientText
                colors={['#40ffaa', '#4079ff', '#40ffaa', '#4079ff', '#40ffaa']}
                animationSpeed={5}
                showBorder={false}
                className="text-8xl mb-4 text-center"
            >
                Welcome to the Neuron
            </GradientText>
        </>
    )
}

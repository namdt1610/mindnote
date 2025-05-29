import Orb from '@/components/Orb'
// const window = globalThis.window || { devicePixelRatio: 1 }

export const Background = () => {
    return (
            <Orb
                hoverIntensity={0.5}
                rotateOnHover={true}
                hue={0}
                forceHoverState={false}
            />
    )
}

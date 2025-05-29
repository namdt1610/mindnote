import { Background } from '@/modules/home/components/Background'
import { Hero } from '@/modules/home/components/Hero'
import { Button } from 'ui'

export default function Page() {
    return (
        <div className="flex items-center justify-center min-h-svh">
            <div className="flex flex-col items-center justify-center gap-4">
                <div
                    style={{
                        position: 'relative',
                        height: '100vh',
                        width: '100vw',
                        overflow: 'hidden',
                    }}
                >
                    <Background />
                    <div className="absolute inset-0 flex flex-col items-center justify-center pointer-events-none">
                        <div className="pointer-events-none">
                            <Hero />
                        </div>
                        <div className="pointer-events-auto pt-4">
                            <Button
                                size="lg"
                                variant="outline"
                                className="text-xl"
                            >
                                S T A R T
                            </Button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    )
}

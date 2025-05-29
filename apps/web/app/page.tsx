import { Button } from 'ui'

export default function Page() {
    return (
        <div className="flex items-center justify-center min-h-svh">
            <div className="flex flex-col items-center justify-center gap-4">
                <h1 className="text-2xl font-bold p-4">
                    Hello World, Welcome to MindNote
                </h1>
                <Button size="sm">Button</Button>
            </div>
        </div>
    )
}

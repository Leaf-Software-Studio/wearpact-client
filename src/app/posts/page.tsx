// wearpact-client/src/app/posts/page.tsx
import { cms } from "@/lib/payload";

export const dynamic = "force-dynamic";

export default async function PostsPage() {
  try {
    const data = await cms.request(`
      query {
        Posts(limit: 10) {
          docs { id title _status }
        }
      }
    `);

    return (
      <main className="p-6">
        <h1 className="text-xl font-bold mb-4">Latest Posts</h1>
        <pre className="text-sm bg-gray-100 p-4 rounded">
          {JSON.stringify(data, null, 2)}
        </pre>
      </main>
    );
  } catch (error) {
    console.error("Error fetching posts:", error);
    return (
      <main className="p-6">
        <h1 className="text-xl font-bold mb-4">Latest Posts</h1>
        <div className="text-red-500">
          Error loading posts. Please try again later.
        </div>
      </main>
    );
  }
}

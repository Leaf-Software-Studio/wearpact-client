// wearpact-client/src/app/posts/page.tsx
import { cms } from "@/lib/payload";

export default async function PostsPage() {
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
}

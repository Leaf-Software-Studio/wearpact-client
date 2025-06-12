// wearpact-client/src/lib/payload.ts
import { GraphQLClient } from "graphql-request";

export const cms = new GraphQLClient(
  `${process.env.NEXT_PUBLIC_CMS_URL}/api/graphql`,
  { credentials: "include" }
);

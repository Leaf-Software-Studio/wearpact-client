# wearpact-client/Dockerfile
FROM node:20-bookworm AS builder
WORKDIR /app
ENV NEXT_TELEMETRY_DISABLED=1
RUN corepack enable && corepack prepare pnpm@9.1.2 --activate

COPY pnpm-lock.yaml package.json ./
RUN pnpm install --frozen-lockfile
COPY . .
RUN pnpm run build

FROM node:20-bookworm AS runner
WORKDIR /app
ENV NODE_ENV=production \ 
    PORT=3100 \ 
    NEXT_TELEMETRY_DISABLED=1
RUN corepack enable && corepack prepare pnpm@9.1.2 --activate && pnpm fetch --prod
COPY --from=builder /app ./
EXPOSE 3100
CMD ["pnpm","start"]

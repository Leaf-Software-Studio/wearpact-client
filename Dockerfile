# wearpact-client/Dockerfile
FROM node:20-alpine AS builder
WORKDIR /app
ENV NEXT_TELEMETRY_DISABLED=1
RUN npm install -g pnpm@9.1.2

COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile
COPY . .
RUN pnpm build

FROM node:20-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production \ 
    PORT=3000 \ 
    NEXT_TELEMETRY_DISABLED=1
RUN npm install -g pnpm@9.1.2 && pnpm fetch --prod
COPY --from=builder /app/package.json ./
COPY --from=builder /app/pnpm-lock.yaml ./
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/next.config.ts ./
RUN pnpm install --prod --frozen-lockfile
EXPOSE 3000
CMD ["pnpm","start"]

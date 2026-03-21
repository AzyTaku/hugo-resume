# ---- Stage 1: Build Hugo site ----
FROM ghcr.io/gohugoio/hugo:v0.158.0 AS builder

# Use a writable directory for Hugo
WORKDIR /src

# Copy all files
COPY . .

# Make /src writable for Hugo (UID 1000)
RUN chown -R 1000:1000 /src

# Run Hugo as root temporarily to avoid permissions issues
USER root
RUN hugo --minify

# ---- Stage 2: Serve with nginx ----
FROM nginx:alpine
COPY --from=builder /src/public /usr/share/nginx/html
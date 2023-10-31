FROM golang:1.18.10-alpine AS builder
ADD . /build
WORKDIR /build

EXPORT GOPROXY=https://mirrors.aliyun.com/goproxy/

RUN GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o release/linux/amd64/drone-wechat-message


FROM plugins/base:multiarch

LABEL maintainer="2430114823@qq.com"

LABEL org.label-schema.version=latest
LABEL org.label-schema.vcs-url="https://github.com/ningge123/drone-wechat-message"
LABEL org.label-schema.name="Drone Wechat Robot"
LABEL org.label-schema.schema-version="1.0"

COPY --from=builder /build/release/linux/amd64/drone-wechat-message /bin/
ENTRYPOINT ["/bin/drone-wechat-message"]
# 阶段 1：使用轻量的 Ubuntu 作为基础
FROM ubuntu:latest

# 安装下载工具和解压工具
RUN apt-get update && apt-get install -y wget unzip ca-certificates && rm -rf /var/lib/apt/lists/*

# 创建配置文件目录
WORKDIR /etc/clewdr

# 【核心步骤】直接从 GitHub 下载作者编译好的最新版二进制文件
# 这里我写的是 v0.12.14，以后有新版你只需要回来改这个版本号
RUN wget https://github.com/xerxes-2/clewdr/releases/download/v0.12.14/clewdr-linux-x86_64.zip && \
    unzip clewdr-linux-x86_64.zip && \
    chmod +x clewdr && \
    mv clewdr /usr/local/bin/clewdr

# 设置环境变量默认值
ENV CLEWDR_IP=0.0.0.0
ENV CLEWDR_PORT=8484

# 暴露 Wiki 指定的 8484 端口
EXPOSE 8484

# 启动命令（告诉程序去哪里找日志和配置）
CMD ["/usr/local/bin/clewdr", "--log-dir", "/etc/clewdr/log"]

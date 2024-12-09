FROM node:18-alpine

WORKDIR /app

# 安装 pnpm
RUN npm install -g pnpm

# 设置 pnpm 镜像源
RUN pnpm config set registry https://registry.npmmirror.com

# 复制 package.json
COPY client/package*.json ./

# 使用 pnpm 安装依赖
RUN pnpm install --no-frozen-lockfile

# 复制源代码
COPY client/ .

EXPOSE 5173

# 开发模式启动
CMD ["pnpm", "run", "dev", "--", "--host"] 
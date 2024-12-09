FROM docker.unsee.tech/node18/alpine

WORKDIR /app

# 安装 pnpm

RUN npm config set registry https://registry.npm.taobao.org

# 设置 pnpm 镜像源
RUN npm config set registry https://registry.npmmirror.com

# 复制 package.json
COPY client/package*.json ./

# 使用 pnpm 安装依赖
RUN npm install
RUN npm cache clean --force && \
    npm install -g vite@2.9.15 && \
    npm install @rollup/rollup-linux-x64-musl @rollup/rollup-linux-x64-gnu --save-optional 
    
# 复制源代码
COPY client/ .

EXPOSE 5173

# 开发模式启动
CMD ["npm", "run", "dev", "--", "--host"] 
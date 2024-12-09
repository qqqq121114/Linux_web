FROM docker.unsee.tech/node:18

WORKDIR /app

# 设置 npm 镜像
RUN npm config set registry https://registry.npmmirror.com

# 安装依赖
COPY client/package*.json ./

RUN npm install -g npm@10.9.2


RUN npm cache clean --force && \
    npm install -g npm@latest && \
   # npm install --platform=linux --arch=x64 && \
  #  npm install @rollup/rollup-linux-x64-gnu && \
    npm rebuild


# 复制源代码
COPY client/ .

EXPOSE 5173

# 开发模式启动
CMD ["npm", "run", "dev", "--", "--host"] 
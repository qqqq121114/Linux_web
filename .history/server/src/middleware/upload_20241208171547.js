const multer = require('multer');
const path = require('path');
const fs = require('fs');

// 确保上传目录存在
const uploadDir = path.join(__dirname, '../../uploads/avatars');
if (!fs.existsSync(uploadDir)) {
  fs.mkdirSync(uploadDir, { recursive: true });
}

// 配置存储
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, uploadDir);
  },
  filename: function (req, file, cb) {
    // 使用时间戳和原始文件扩展名创建唯一文件名
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, uniqueSuffix + path.extname(file.originalname));
  }
});

// 文件过滤器
const fileFilter = (req, file, cb) => {
  // 只允许上传图片
  if (file.mimetype.startsWith('image/')) {
    cb(null, true);
  } else {
    cb(new Error('只允许上传图片文件！'), false);
  }
};

// 创建 multer 实例
const upload = multer({
  storage: storage,
  fileFilter: fileFilter,
  limits: {
    fileSize: 5 * 1024 * 1024, // 限制文件大小为 5MB
  }
});

module.exports = upload; 
import { http } from '@kit.NetworkKit';

const baseUrl = 'http://192.168.56.1:3000';

export const getData = async (path: string) => {
  const req = http.createHttp();
  try {
    const res = await req.request(baseUrl + path, {
      expectDataType: http.HttpDataType.OBJECT
    });
    req.destroy();
    return res.result;
  } catch (error) {
    req.destroy();
    // 完全去掉弹窗，只打印日志 → 0 报错
    console.error('网络请求失败', JSON.stringify(error));
    throw new Error(`请求失败：${error.message}`);
  }
};

export const getSwiper = async () => {
  return await getData('/data/swiper');
};

export const getDailyRecommend = async () => {
  return await getData('/data/dailyRecommend');
};

export const getRecommendList = async () => {
  return await getData('/data/recommendList');
};

export const getSongList = async () => {
  return await getData('/data/songList');
};

export const getMomentList = async () => {
  return await getData('/data/momentList');
};
import { http } from '@kit.NetworkKit';
import { promptAction } from '@kit.ArkUI';

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
    promptAction.showToast({ message: '网络请求失败' });
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

// 新增：获取猜你喜欢歌曲列表
export const getSongList = async () => {
  return await getData('/data/songList');
};
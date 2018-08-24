package cn.ycoder.loan.loanarchive.utils;

import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.content.res.Resources;
import android.util.DisplayMetrics;
import android.util.Log;


/**
 * Created by Yu on 2016/8/5.
 */
public class ScreenInfo {

  private static final String KEY_DESIGN_WIDTH = "DESIGN_WIDTH";

  /**
   * 屏幕的真实宽度.
   */
  public int screenWidth;

  /**
   * 屏幕的真实高度.
   */
  public int screenHeight;
  /**
   * 设计宽度
   */
  public int designWidth;
  /**
   * 状态栏高度.
   */
  public int statusBarHeight;

  /**
   * The density.
   */
  public float density;

  /**
   * The scale density.
   */
  public float scaleDensity;

  /**
   * The xdpi.
   */
  public float xdpi;

  /**
   * The ydpi.
   */
  public float ydpi;

  /**
   * The density dpi.
   */
  public int densityDpi;

  /**
   * The screen min.
   */
  public int screenMin; // 宽高中，最小的值
  /**
   * The current orientation.
   */
  private int currentOrientation;

  private static ScreenInfo screenInfo;

  public static ScreenInfo getInstance(Context context) {
    context = context.getApplicationContext();
    if (screenInfo == null) {
      synchronized (ScreenInfo.class) {
        if (screenInfo == null) {
          screenInfo = new ScreenInfo(context);
        }
      }
    }
    return screenInfo;
  }

  private ScreenInfo() {

  }

  private ScreenInfo(Context context) {
    if (null == context) {
      return;
    }
    if (statusBarHeight == 0) {
      try {
        statusBarHeight = context.getResources().getDimensionPixelSize(
            Resources.getSystem().getIdentifier("status_bar_height", "dimen", "android"));
      } catch (Exception e) {
        // Ignore
      }
    }
    DisplayMetrics dm = context.getResources().getDisplayMetrics();
    screenWidth = Math.min(dm.widthPixels, dm.heightPixels - statusBarHeight);
    screenHeight = Math.max(dm.widthPixels, dm.heightPixels - statusBarHeight);
    // 每英寸多少个像素点
    density = dm.density;
    scaleDensity = dm.scaledDensity;
    xdpi = dm.xdpi;
    ydpi = dm.ydpi;
    densityDpi = dm.densityDpi;
    screenMin = (screenWidth > screenHeight) ? screenHeight : screenWidth;
    currentOrientation = context.getResources().getConfiguration().orientation;
    Log.i("ScreenInfo", "densityDpi:" + densityDpi + "," + screenWidth + "x" + screenHeight);
    PackageManager packageManager = context.getPackageManager();
    ApplicationInfo applicationInfo;
    try {
      applicationInfo = packageManager.getApplicationInfo(context
          .getPackageName(), PackageManager.GET_META_DATA);
      if (applicationInfo != null && applicationInfo.metaData != null && !applicationInfo.metaData
          .isEmpty()) {
        designWidth = applicationInfo.metaData.getInt(KEY_DESIGN_WIDTH, 750);
      }
    } catch (PackageManager.NameNotFoundException e) {
      throw new RuntimeException(
          "you must set " + KEY_DESIGN_WIDTH + "  in your manifest file.", e);
    }
    Log.i("ScreenInfo", " designWidth =" + designWidth);
  }

  /**
   * dip转px.
   *
   * @param dipValue the dip value
   * @return the int
   */
  public static int dip2px(Context context,float dipValue) {
    final float scale = ScreenInfo.getInstance(context).density;
    return (int) (dipValue * scale + 0.5f);
  }

  /**
   * px转dip.
   *
   * @param pxValue the px value
   * @return the int
   */
  public static int px2dip(Context context,float pxValue) {
    final float scale = ScreenInfo.getInstance(context).density;
    return (int) (pxValue / scale + 0.5f);
  }

  /**
   * 获取换算比例宽度
   *
   * @param val 设计图宽度
   */
  public static int getPercentWidthSize(Context context,int val) {
    ScreenInfo si = ScreenInfo.getInstance(context);
    return Math.round(val * (si.screenWidth * 1f / si.designWidth));
  }

  /**
   * 获取换算比例高度
   *
   * @param val 设计图高度
   */
  public static int getPercentHeightSize(Context context,int val) {
    ScreenInfo si = ScreenInfo.getInstance(context);
    return Math.round(val * (si.screenWidth * 1f / si.designWidth));
  }

}

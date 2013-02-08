/**
A simple tween with quadratic ease in
*/

class Tween {
  float value;
  float startValue;
  float endValue;
  
  float currentTime;
  float duration;
  
  Tween(float start, float end, float duration)
  {
    setDuration(duration);
    value = start;
    startValue = start;
    endValue = end;
  }
  
  float getValue()
  {
    return value;
  }
  
  boolean getComplete()
  {
    return currentTime == duration;
  }
  
  void setDuration(float time)
  {
    if( time < 0.0f ){ time = -time; } // ending always comes after beginning in real time
    if( time == 0.0f ){ time += 1.0f/60.0f; } // must not be zero, for divisions sake
    duration = time;
  }
  
  void reset()
  {
    currentTime = 0.0f;
  }
  
  /**
   * Step our animation in time
   */
  void step(float t)
  {
    currentTime += t;
    if( currentTime > duration ){ currentTime = duration; }
    else if (currentTime < 0.0f){ currentTime = 0.0f; }
    float normalizedTime = currentTime / duration;
    float easedTime = normalizedTime * normalizedTime * normalizedTime; // ease in cubic
    value = startValue + (endValue - startValue) * easedTime;
  }

}

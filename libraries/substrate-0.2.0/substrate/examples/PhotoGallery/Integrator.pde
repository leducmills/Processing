/**
 * Integrator integrates values for animation
 *
 */
class Integrator
{
  float value;
  float target;
  float stiffness;

  Integrator()
  {
    value = 0.0f;
    target = 0.0f;
    stiffness = 0.2f;
  }

  void step()
  {
    value += (target - value) * stiffness;
  }
}


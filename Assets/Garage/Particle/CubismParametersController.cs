using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Live2D.Cubism.Core;

public class CubismParametersController : MonoBehaviour
{
  private CubismModel model;
  private float _time;
  private int l;

  private void Start()
  {
      model = GetComponent<CubismModel>();
      l = model.Parameters.Length;
  }

  private void LateUpdate()
  {
       _time += Time.deltaTime;
       for (int i = 0; i < l; i++)
       {
           model.Parameters[i].Value = Mathf.Sin(_time * (1 + i * 0.3f) );   
       }
  }
}

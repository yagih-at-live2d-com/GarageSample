using UnityEngine;

public class CubismPostEffect : MonoBehaviour
{
    [SerializeField] Material _mat;
    void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        Graphics.Blit(src, dest, _mat);
    }
    
}
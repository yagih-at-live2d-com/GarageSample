Shader "Live2D Cubism/Mosaic"{
    Properties {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _PixelNumber ("PixelNum", float) = 100
    }

    SubShader {
        Pass {
            Tags { "RenderType"="Opaque" }

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            sampler2D _MainTex;
            float _PixelNumber;

            struct v2f {
                half4 pos : POSITION;
                half2 uv : TEXCOORD0;
            };

            float4 _MainTex_ST;

            v2f vert(appdata_base v) {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
                return o;
            }

            half4 frag(v2f IN) : COLOR {
                half2 uv = floor(IN.uv * _PixelNumber) / _PixelNumber;
                fixed4 mosaicColor = tex2D(_MainTex, uv);
                return mosaicColor;
            }

            ENDCG
        }
    }
    FallBack "Diffuse"
}
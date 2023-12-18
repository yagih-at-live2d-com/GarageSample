/*
* Copyright(c) Live2D Inc. All rights reserved.
*
* Use of this source code is governed by the Live2D Open Software license
* that can be found at http://live2d.com/eula/live2d-open-software-license-agreement_en.html.
*/

Shader "Live2D Cubism/Blur"{
    Properties {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _Size ("Size", float) = 100
        _Spacing ("Spacing", float) = 0.001
    }

    SubShader {
        Pass {
            Tags { "RenderType"="Opaque" }

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            sampler2D _MainTex;
            float _Size;
            float _Spacing;


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

			half4 frag(v2f IN) : SV_Target
			{
				fixed4 sum = fixed4(0,0,0,0);
				
                float2 texelSize = _Spacing;
			    texelSize.y *= _ScreenParams.y / _ScreenParams.x;

                for (float x = -_Size; x <= _Size; x++)
                {
                    for (float y = -_Size; y <= _Size; y++)
                    {
                        float2 offset = float2(x, y) * texelSize * 0.5;
                        sum.rgba += tex2D(_MainTex, IN.uv + offset).rgba;   
                    }
                }

				fixed s = pow(_Size * 2 + 1,2);
				fixed4 blurredColor = sum / s;
				
				return blurredColor;
			}

            ENDCG
        }
    }
    FallBack "Diffuse"
}

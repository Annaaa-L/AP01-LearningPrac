// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33250,y:32607,varname:node_3138,prsc:2|emission-7699-RGB,olwid-3769-OUT,olcol-4376-OUT;n:type:ShaderForge.SFN_LightVector,id:2672,x:32290,y:32784,varname:node_2672,prsc:2;n:type:ShaderForge.SFN_NormalVector,id:6622,x:32290,y:32619,prsc:2,pt:False;n:type:ShaderForge.SFN_Dot,id:8417,x:32442,y:32694,varname:node_8417,prsc:2,dt:0|A-6622-OUT,B-2672-OUT;n:type:ShaderForge.SFN_Vector1,id:7468,x:32442,y:32608,varname:node_7468,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Multiply,id:6375,x:32624,y:32574,varname:node_6375,prsc:2|A-7468-OUT,B-8417-OUT;n:type:ShaderForge.SFN_Vector1,id:4573,x:32588,y:32717,varname:node_4573,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Add,id:7830,x:32788,y:32579,varname:node_7830,prsc:2|A-6375-OUT,B-4573-OUT;n:type:ShaderForge.SFN_Append,id:6908,x:32988,y:32579,varname:node_6908,prsc:2|A-7830-OUT,B-104-OUT;n:type:ShaderForge.SFN_Vector1,id:104,x:32788,y:32717,varname:node_104,prsc:2,v1:0.3;n:type:ShaderForge.SFN_Tex2d,id:7699,x:33055,y:32792,ptovrint:False,ptlb:node_7699,ptin:_node_7699,varname:node_7699,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:5e757e1144f578548b033e766f4f1716,ntxv:0,isnm:False|UVIN-6908-OUT;n:type:ShaderForge.SFN_Vector1,id:3769,x:33055,y:32959,varname:node_3769,prsc:2,v1:0.015;n:type:ShaderForge.SFN_Vector3,id:4376,x:33055,y:33026,varname:node_4376,prsc:2,v1:0.2,v2:0.08,v3:0.26;proporder:7699;pass:END;sub:END;*/

Shader "L01/HW" {
    Properties {
        _node_7699 ("node_7699", 2D) = "white" {}
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "Outline"
            Tags {
            }
            Cull Front
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma target 3.0
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( float4(v.vertex.xyz + v.normal*0.015,1) );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                return fixed4(float3(0.2,0.08,0.26),0);
            }
            ENDCG
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform sampler2D _node_7699; uniform float4 _node_7699_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                LIGHTING_COORDS(2,3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
////// Lighting:
////// Emissive:
                float2 node_6908 = float2(((0.5*dot(i.normalDir,lightDirection))+0.5),0.3);
                float4 _node_7699_var = tex2D(_node_7699,TRANSFORM_TEX(node_6908, _node_7699));
                float3 emissive = _node_7699_var.rgb;
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma target 3.0
            uniform sampler2D _node_7699; uniform float4 _node_7699_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                LIGHTING_COORDS(2,3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
////// Lighting:
                float3 finalColor = 0;
                return fixed4(finalColor * 1,0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}

// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33423,y:32679,varname:node_3138,prsc:2|emission-9742-RGB;n:type:ShaderForge.SFN_Dot,id:6400,x:32534,y:32741,varname:node_6400,prsc:2,dt:0|A-5444-OUT,B-5299-OUT;n:type:ShaderForge.SFN_NormalVector,id:5444,x:32367,y:32615,prsc:2,pt:False;n:type:ShaderForge.SFN_LightVector,id:5299,x:32367,y:32843,varname:node_5299,prsc:2;n:type:ShaderForge.SFN_Multiply,id:982,x:32707,y:32854,varname:node_982,prsc:2|A-6400-OUT,B-9985-OUT;n:type:ShaderForge.SFN_Vector1,id:9985,x:32534,y:32900,varname:node_9985,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Add,id:6186,x:32872,y:32798,varname:node_6186,prsc:2|A-6085-OUT,B-982-OUT;n:type:ShaderForge.SFN_Vector1,id:6085,x:32707,y:32754,varname:node_6085,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Vector1,id:9681,x:32872,y:32959,varname:node_9681,prsc:2,v1:0.2;n:type:ShaderForge.SFN_Append,id:6753,x:33034,y:32868,varname:node_6753,prsc:2|A-6186-OUT,B-9681-OUT;n:type:ShaderForge.SFN_Tex2d,id:9742,x:33232,y:32868,ptovrint:False,ptlb:node_9742,ptin:_node_9742,varname:node_9742,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:d7cd16145b6127145a1c3b02b2c4f44d,ntxv:0,isnm:False|UVIN-6753-OUT;proporder:9742;pass:END;sub:END;*/

Shader "AP1/L01/RampTex" {
    Properties {
        _node_9742 ("node_9742", 2D) = "white" {}
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
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
            uniform sampler2D _node_9742; uniform float4 _node_9742_ST;
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
                float2 node_6753 = float2((0.5+(dot(i.normalDir,lightDirection)*0.5)),0.2);
                float4 _node_9742_var = tex2D(_node_9742,TRANSFORM_TEX(node_6753, _node_9742));
                float3 emissive = _node_9742_var.rgb;
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
            uniform sampler2D _node_9742; uniform float4 _node_9742_ST;
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

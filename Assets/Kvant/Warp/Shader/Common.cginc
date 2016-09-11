//
// Kvant/Warp - Warp (hyperspace) light streaks effect
//
// Copyright (C) 2016 Keijiro Takahashi
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#include "UnityCG.cginc"

// Seed for PRNG
float _RandomSeed;

// PRNG function
float LineRandom(float ln, float salt)
{
    float2 uv = float2(ln, salt * 0.938198424 + _RandomSeed * 11.0938495);
    return frac(sin(dot(uv, float2(12.9898, 78.233))) * 43758.5453);
}

// Line parameters
float _LineRadius;
float2 _LineWidth; // (min, max)

float3 ApplyLineParams(float3 v, float ln)
{
    float sz = lerp(_LineWidth.x, _LineWidth.y, LineRandom(ln, 0));
    return v * float3(_LineRadius, _LineRadius, sz);
}

// Line position
float3 _Extent;
float _SpeedRandomness;
float _NormalizedTime;

float3 GetLinePosition(float ln)
{
    float z = LineRandom(ln, 4);
    z = z + _NormalizedTime * (1 - _SpeedRandomness * LineRandom(ln, 1));

    ln += trunc(z);
    float2 xy = float2(LineRandom(ln, 2), LineRandom(ln, 3));

    return (float3(xy, frac(z)) - 0.5) * _Extent;
}

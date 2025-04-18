/*

    Copyright (c) 2025 Pocketz World. All rights reserved.

    This is a generated file, do not edit!

    Generated by com.pz.studio
*/

#if UNITY_EDITOR

using System;
using System.Linq;
using UnityEngine;
using Highrise.Client;
using Highrise.Studio;
using Highrise.Lua;

namespace Highrise.Lua.Generated
{
    [AddComponentMenu("Lua/ResourceOrigin")]
    [LuaRegisterType(0x7ad941e1ff28ac7f, typeof(LuaBehaviour))]
    public class ResourceOrigin : LuaBehaviourThunk
    {
        private const string s_scriptGUID = "b14da0b04d1e59a428097ff6389cef7b";
        public override string ScriptGUID => s_scriptGUID;

        [SerializeField] public System.Double m_uniqueID = 0;
        [SerializeField] public System.String m_objectName = "";
        [SerializeField] public System.Collections.Generic.List<System.Boolean> m_seasons = default;
        [LuaScriptPropertyAttribute("f991541301db6dd47b91752d96328df4")]
        [SerializeField] public System.Collections.Generic.List<UnityEngine.Object> m_resources = default;
        [SerializeField] public System.Double m_renewTime = 0;
        [SerializeField] public UnityEngine.GameObject m_itemParticle = default;

        protected override SerializedPropertyValue[] SerializeProperties()
        {
            if (_script == null)
                return Array.Empty<SerializedPropertyValue>();

            return new SerializedPropertyValue[]
            {
                CreateSerializedProperty(_script.GetPropertyAt(0), m_uniqueID),
                CreateSerializedProperty(_script.GetPropertyAt(1), m_objectName),
                CreateSerializedProperty(_script.GetPropertyAt(2), m_seasons),
                CreateSerializedProperty(_script.GetPropertyAt(3), m_resources),
                CreateSerializedProperty(_script.GetPropertyAt(4), m_renewTime),
                CreateSerializedProperty(_script.GetPropertyAt(5), m_itemParticle),
            };
        }
    }
}

#endif

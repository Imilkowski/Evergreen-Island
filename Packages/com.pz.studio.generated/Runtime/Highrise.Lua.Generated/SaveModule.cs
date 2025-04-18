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
    [AddComponentMenu("Lua/SaveModule")]
    [LuaRegisterType(0x8f5d59af62e39260, typeof(LuaBehaviour))]
    public class SaveModule : LuaBehaviourThunk
    {
        private const string s_scriptGUID = "f3d16a2d5617bee409c749ae3cc9d147";
        public override string ScriptGUID => s_scriptGUID;

        [SerializeField] public System.Double m_saveToCloudInterval = 0;
        [SerializeField] public System.Double m_inventorySize = 0;

        protected override SerializedPropertyValue[] SerializeProperties()
        {
            if (_script == null)
                return Array.Empty<SerializedPropertyValue>();

            return new SerializedPropertyValue[]
            {
                CreateSerializedProperty(_script.GetPropertyAt(0), m_saveToCloudInterval),
                CreateSerializedProperty(_script.GetPropertyAt(1), m_inventorySize),
            };
        }
    }
}

#endif

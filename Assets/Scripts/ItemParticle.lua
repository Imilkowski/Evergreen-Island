--!Type(Client)

local playerTransform = nil
local rigidbody = nil

local attractionForce = 20

function self:Awake()
    rigidbody = self:GetComponent(Rigidbody)
end

function SetUp(pos, icon)
    playerTransform = client.localPlayer.character.transform
    self.transform.position = pos

    local renderer = self:GetComponent(Renderer)
    renderer.material.mainTexture = icon

    local angle = Random.Range(0, 2 * math.pi)
    local spread = Random.Range(0, 5)
    local direction = Vector3.new(Mathf.Cos(angle) * spread, 1, Mathf.Sin(angle) * spread).normalized

    rigidbody:AddForce(direction * 10, ForceMode.Impulse)
end

function self:FixedUpdate()
    if(playerTransform == nil) then return end

    local direction = (playerTransform.position + Vector3.new(0, 0.75, 0) - self.transform.position)

    if(direction.magnitude < 0.5) then
        GameObject.Destroy(self.gameObject)
    end

    rigidbody:AddForce(direction.normalized * attractionForce)
end
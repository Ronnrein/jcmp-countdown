class "Countdown"
function Countdown:__init()
    self.lastTime = 0
    self.currentNum = 0
    self.counting = false

    Events:Subscribe("PostTick", self, self.PostTick)
    Events:Subscribe("PlayerChat", self, self.PlayerChat)
end

function Countdown:PlayerChat(args)
    if self.counting == false then
        local words = args.text:split(" ")
        if words[1] == "/cd" then
            self.currentNum = 3
            if #words == 2 then
                local newNum = tonumber(words[2])
                if newNum >=3 and newNum <= 5 then
                    self.currentNum = newNum
                end
            end
            self.counting = true;
            self.lastTime = os.time()
        end
    end
end

function Countdown:PostTick(args)
    if self.counting then
        if os.difftime(os.time(), self.lastTime) >= 1 then
            if self.currentNum > 0 then
                self:ShowMsg(tostring(self.currentNum))
                self.currentNum = self.currentNum - 1
                self.lastTime = os.time()
            else
                self:ShowMsg("Go!")
                self.counting = false
            end
        end
    end
end

function Countdown:ShowMsg(msg)
    Chat:Broadcast(msg, Color(0, 240, 240))
end

countdown = Countdown()
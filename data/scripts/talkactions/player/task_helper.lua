local task_helper = TalkAction("!task")

local task_info = [[
[Task Helper]

To start a task, you need to go to the 
NPC Grizzly Adams located in Thais.

You have %s task points.

%s]]

local function sendTaskHelperWindow(player)
	local activeTasks = CustomTask.getActiveTasks(player)
	local next_text
	if activeTasks and #activeTasks > 0 then
		local taskStr = {}
		for _, taskId in pairs(activeTasks) do
			local taskData = CustomTask.tasks[taskId]
			if taskData then
				local temp = string.format("[%s] %s/%s killed", taskData.name, player:getStorageValue(CustomTask.taskStorages(taskId).kills), taskData.kills)
				table.insert(taskStr, temp)
			end
		end
		next_text = string.format(task_info, CustomTask.taskPointsManager(player, "get"), "You have tasks started:\n"..table.concat(taskStr, "\n"))
	else
		next_text = string.format(task_info, CustomTask.taskPointsManager(player, "get"), "You currently have no active tasks.")
	end
	if next_text then
		player:popupFYI(next_text)
	end
end

function task_helper.onSay(player, words, param)
	sendTaskHelperWindow(player)
	return false
end

task_helper:register()

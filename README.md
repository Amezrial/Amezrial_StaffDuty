# Amezrial Staff Duty

A FiveM resource using webhook in Discord for toggling staff duty status.

## Features
1. Notification in chat only the source can see.
2. Discord Webook is all that is needed to connect to Discord and Fivem.
3. Goes OFFDuty when /staffduty is used a second time, quiting from F8, if the server is restarted, or Fivem crashes.
4. Logs total hours and minutes of OnDuty when you Go OffDuty.

   ![image](https://github.com/Amezrial/Amezrial_StaffDuty/assets/44910717/59096d91-ae48-4602-ad75-54037cf9a14f)
   
   ![image](https://github.com/Amezrial/Amezrial_StaffDuty/assets/44910717/05425d58-2182-4106-9531-85edf9f24cbf)


## Installation

1. **Download and Setup:**
   - Download the `Amezrial_StaffDuty` resource.
   - Extract the folder to your server resources directory. The path should look like `/resources/Amezrial_StaffDuty`.

2. **Modify `server.cfg`:**
   - Add the following line to your `server.cfg` to ensure the resource is loaded:
     ```
     ensure Amezrial_StaffDuty
     ```

## Configuration

1. **Discord Webhook:**
   - You need to set up a Discord webhook to receive notifications. [Follow these instructions](https://support.discord.com/hc/en-us/articles/228383668-Intro-to-Webhooks) to create a webhook in your Discord server.
   - Once you have your webhook URL, replace `'YOUR_DISCORD_WEBHOOK_URL'` in `server.lua` with your actual webhook URL.

2. **Setting up ACE permissions:**
   - You need to add ACE permissions in your `server.cfg` to control who can use the staff duty command. Here’s how to set it up:
     ```
     # Granting the staff duty permission (replace group.staff with your role you want to use)
     add_ace group.staff "amezrial.staff" allow
     # Assigning the permission to a specific player or role
     add_principal identifier.discord:RoleID group.staff
     ```

   - Replace `RoleID` with the appropriate Discord Role ID or other identifier types according to your authentication method.

## Usage

- **Toggling Staff Duty:**
  - In-game, authorized users can use the `/staffduty` command to toggle their staff duty status.
  - Status changes (On Duty and Off Duty) are shown only to the source (person going on and off duty) in-game and sent to the specified Discord channel you chose in your webhook.

## Support

For support, questions, or more information, please visit [https://github.com/Amezrial/Amezrial_StaffDuty](https://github.com/Amezrial/Amezrial_StaffDuty) or join our Discord server (https://discord.gg/m3ARKuWNUb).

Enjoy managing your staff duties more effectively with `Amezrial_StaffDuty`!

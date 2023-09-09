# crystal-rshell
Remote Shell written in Crystal &amp; Ruby

### Requirements
- Ruby 3.x
- Crystal 
- Rake (Optional)

### Example Playbook 
**Start Server**
```bash
ruby server.rb 1984
```
**Connect client to the server**
don't forget to build client with crystal: `crystal build client.cr`
```bash
./client 0.0.0.0 1984
```

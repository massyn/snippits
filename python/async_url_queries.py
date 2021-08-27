import asyncio
import aiohttp

class asyncCalls:
    def __init__(self,semaphore = 10):
        self.semaphore = semaphore
        self.myList = []

    def queue(self,i):
        for t in ['url','key']:
            if not t in i:
                print(f' ** Missing {t} in queue ** ')
                exit(1)
        if not 'header' in i:
            i['header'] = None
        
        self.myList.append(i)

    async def call_api(self,sem,Q):
        async with sem:
            async with aiohttp.ClientSession(headers = Q['header']) as session:
                async with session.get(Q['url']) as resp:
                    assert resp.status == 200
                    x = await resp.text()
                    return { 'key' : Q['key'], 'text' : x }

    async def run_query(self,queries):
        sem = asyncio.Semaphore(self.semaphore)
        return await asyncio.gather(*[self.call_api(sem, query) for query in queries])

    def run(self):
        asyncio.set_event_loop_policy(asyncio.WindowsSelectorEventLoopPolicy()) # to be set on Windows
        return asyncio.run(self.run_query(self.myList))
  

if __name__ == '__main__':
    
    p = asyncCalls(10)
    
    # -- this example calls a delay of 5 seconds, 10 times.  Under a sequential script, it should take 50 seconds to run.  With async,
    # -- it will complete in just over 5 seconds (depending on your network)
    
    for x in range(10):
        # -- if you need to pass headers, do it here (headers)
        p.queue({'url' : 'https://httpbin.org/delay/5', 'key' : x })
        
    for x in p.run():
        # use the key to see what the original key value was.    text will contain the output from the API
        print(x['key'])
        print(x['text'])
        print('-----------------')

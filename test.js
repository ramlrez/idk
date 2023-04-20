const sharp = require('sharp');
const axios = require('axios');
const fs = require('fs');
const exp = require('express');
const app = exp();
const port = 666;



const convertImage = data => {

    return new Promise((res,rej) => {

sharp(data)
        .resize({ width: 32, height: 32 })
        .raw({ channels: 3 })
        .toBuffer((err, data, info) => {
            if (err) {
                console.error(err);
            } else {
                let index = 0;
                let pixels = [];
                for (let i = 0; i < info.width * info.height * 3; i += 3) {
                    const r = data[i];
                    const g = data[i + 1];
                    const b = data[i + 2];
                    pixels[index] = ({
                        r,
                        g,
                        b
                    });

		    if (index === 1023) return res(pixels);
                    index++;
                }
		
              
              return rej('Couldnt map the image');
            }
        });
    });	

}





app.get('/', (req, res) => {
    if (!req.query.url) return res.send('make sure to add on the url "?url=yourlinkhere"');
    axios.get(req.query.url, { responseType: 'stream' }).then(response => {
	let buffer = [];
        response.data.on('data', chunk => {
            buffer.push(chunk);
        });
        response.data.on('end', async() => {
            let px = await convertImage(Buffer.concat(buffer));
            res.json({ px });
        });
    }).catch(err => {
        console.error(err);
    });

});

app.listen(port, () => {
    console.log('app running on port ' + port);
});
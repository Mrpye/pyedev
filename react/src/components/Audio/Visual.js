import React, { Component } from 'react';


class Visual extends Component {
    constructor(props) {
        super(props)
        /*this.state = {
          audioSrc: null,
            context: null,
        };*/
        this.createVisualization = this.createVisualization.bind(this)
    }

    componentDidMount() {
        if(this.props.audio_src!=null && this.props.context!=null){
            console.log("componentDidMount");
            this.createVisualization()
        }
        
    }
    componentDidUpdate(prevProps) {
        if (this.props.audio_src !== prevProps.audio_src) {

            if(this.props.audio_src!=null   ){
                console.log("createVisualization",this.props.audio_src);
                this.createVisualization()
            }  
        }
    }

    createVisualization() {
        // var n = scaleValue(33, [0,100], [0,65535]);
        function scaleValue(value, from, to) {
            var scale = (to[1] - to[0]) / (from[1] - from[0]);
            var capped = Math.min(from[1], Math.max(from[0], value)) - from[0];
            return ~~(capped * scale + to[0]);
        }


        //Set up the audio
        var audioSrc=this.props.audio_src;
        var context = this.props.audio_src.context;
        
        //console.log(context);
        let image = new Image(); // Using optional size for image
        let analyser = context.createAnalyser();
        let canvas = this.refs.analyzerCanvas;
        let ctx = canvas.getContext('2d');
        audioSrc.connect(analyser);
        analyser.connect(context.destination);
        let current_img = 0;
        let total_frames = 7;
        let wait_between_frame = 4;
        let current_wait_between_frame = 4;
        let fade = 0.1;
        image.src = process.env.PUBLIC_URL + "/img/animation2.png";

        var ball = {
            x: 100,
            y: 100,
            vx: 1,
            vy: 2,
            saturation: { freq: 2, min: 0, max: 200 },
            opacity: { freq: 75, min: 0, max: 100 },
            hue_rotate: { freq: 2, min: 0, max: 360 },
            blur: { freq: 2, min: 0, max: 2 },
            r: { freq: 100, min: 255, max: 0 },
            g: { freq: 60, min: 255, max: 0 },
            b: { freq: 2, min: 0, max: 2 },
            sx: { freq: 30, min: 0, max:1 },
            sy: { freq: 50, min: 0, max: 3 },
            radius: { freq: 80, min: 0, max: 50 },
            stroke: true,
            fill: true
        };
        var ball2 = {
            x: 0,
            y: 0,
            vx: 4,
            vy: 1,
            saturation: { freq: 2, min: 0, max: 200 },
            opacity: { freq: 75, min: 0, max: 100 },
            hue_rotate: { freq: 2, min: 0, max: 360 },
            blur: { freq: 2, min: 0, max: 2 },
            r: { freq: 100, min: 0, max: 0 },
            g: { freq: 60, min: 0, max: 255 },
            b: { freq: 2, min: 0, max: 2 },
            sx: { freq: 2, min: 0, max: 2 },
            sy: { freq: 50, min: 0, max: 2 },
            radius: { freq: 80, min: 0, max: 100 },
            stroke: true,
            fill: true
        };

        //let p=2 * Math.PI;
       



        function animateBall(ball, freqData) {

            var sat = scaleValue(freqData[ball.saturation.freq], [0, 255], [ball.saturation.min, ball.saturation.max]);
            var opacity = scaleValue(freqData[ball.opacity.freq], [0, 255], [ball.opacity.min, ball.opacity.max]);
            var hue_rotate = scaleValue(freqData[ball.hue_rotate.freq], [0, 255], [ball.hue_rotate.min, ball.hue_rotate.max]);
            var blur = scaleValue(freqData[ball.blur.freq], [0, 255], [ball.blur.min, ball.blur.max]);
            var r = scaleValue(freqData[ball.r.freq], [0, 255], [ball.r.min, ball.r.max]);
            var g = scaleValue(freqData[ball.g.freq], [0, 255], [ball.g.min, ball.g.max]);
            var b = scaleValue(freqData[ball.b.freq], [0, 255], [ball.b.min, ball.b.max]);
            var sx = scaleValue(freqData[ball.sx.freq], [0, 255], [ball.sx.min, ball.sx.max]);
            var sy = scaleValue(freqData[ball.sy.freq], [0, 255], [ball.sy.min, ball.sy.max]);
            var radius = scaleValue(freqData[ball.radius.freq], [0, 255], [ball.radius.min, ball.radius.max]);

            if (freqData[2] > 0) {
                ctx.filter = 'blur(' + blur + 'px) hue-rotate(' + hue_rotate + 'deg) saturate(' + sat + '%) opacity(' + opacity + '%)';
                ctx.beginPath();
                ctx.arc(ball.x, ball.y, radius, 0, Math.PI * 2, true);
                ctx.closePath();
                if (ball.stroke == true) {
                    ctx.strokeStyle = `rgb(
                        ${Math.floor(r)},
                        ${Math.floor(g)},
                        ${Math.floor(b)})`;
                    ctx.stroke();
                }
                if (ball.fill == true) {
                    ctx.fillStyle = `rgb(
                            ${Math.floor(r)},
                            ${Math.floor(g)},
                            ${Math.floor(b)})`;
                    ctx.fill();
                }

                ctx.filter = 'blur(0px) hue-rotate(0deg) saturate(100%) opacity(100%)';
            }
            ball.x += ball.vx + sx;
            ball.y += ball.vy + sy;


            if (ball.y + ball.vy > canvas.height || ball.y + ball.vy < 0) {
                ball.vy = -ball.vy;
            }
            if (ball.x + ball.vx > canvas.width || ball.x + ball.vx < 0) {
                ball.vx = -ball.vx;
            }


        }
        var bar = {
            stroke_r: { freq: 100, min: 0, max: 255 },
            stroke_g: { freq: 60, min: 255, max: 0 },
            stroke_b: { freq: 2, min: 0, max: 0 },
            fill_r: { freq: 100, min: 0, max: 20 },
            fill_g: { freq: 25, min: 0, max: 0 },
            fill_b: { freq: 2, min: 0, max: 255 },
            saturation: { freq: 2, min: 0, max: 300 },
            opacity: { freq: 75, min: 100, max: 100 },
            hue_rotate: { freq: 50, min: 0, max: 360},
            blur: { freq: 2, min: 0, max: 0},
            step: 10,
            width: 10,
            stroke: false,
            fill: true
        };

        function renderBar(bar, freqData) {

            let bars = 100;
            for (var i = 0; i < bars; i += bar.step) {

                var r = scaleValue(freqData[bar.stroke_r.freq], [0, 255], [bar.stroke_r.min, bar.stroke_r.max]);
                var g = scaleValue(freqData[bar.stroke_g.freq], [0, 255], [bar.stroke_g.min, bar.stroke_g.max]);
                var b = scaleValue(freqData[bar.stroke_b.freq], [0, 255], [bar.stroke_b.min, bar.stroke_b.max]);

                var fr = scaleValue(freqData[bar.fill_r.freq], [0, 255], [bar.fill_r.min, bar.fill_r.max]);
                var fg = scaleValue(freqData[bar.fill_g.freq], [0, 255], [bar.fill_g.min, bar.fill_g.max]);
                var fb = scaleValue(freqData[bar.fill_b.freq], [0, 255], [bar.fill_b.min, bar.fill_b.max]);

                var sat = scaleValue(freqData[bar.saturation.freq], [0, 255], [bar.saturation.min, bar.saturation.max]);
                var opacity = scaleValue(freqData[bar.opacity.freq], [0, 255], [bar.opacity.min, bar.opacity.max]);
                var hue_rotate = scaleValue(freqData[bar.hue_rotate.freq], [0, 255], [bar.hue_rotate.min, bar.hue_rotate.max]);
                var blur = scaleValue(freqData[bar.blur.freq], [0, 255], [bar.blur.min, bar.blur.max]);

                let bar_x = i * 3;
                let bar_width = bar.width;
                let bar_height = -(freqData[i] / 2);
               ctx.filter = 'blur(' + blur + 'px) hue-rotate(' + hue_rotate + 'deg) saturate(' + sat + '%) opacity(' + opacity + '%)';

                if (bar.fill == true) {
                    ctx.fillStyle = `rgb(
                            ${Math.floor(r)},
                            ${Math.floor(g)},
                            ${Math.floor(b)})`;
                    ctx.fillRect(bar_x, canvas.height, bar_width, bar_height);
                }
                if (bar.stroke == true) {
                    ctx.strokeStyle = `rgb(
                        ${Math.floor(fr)},
                        ${Math.floor(fg)},
                        ${Math.floor(fb)})`;
                    ctx.strokeRect(bar_x, canvas.height, bar_width, bar_height);
                }
                ctx.filter = 'blur(0px) hue-rotate(0deg) saturate(100%) opacity(100%)';
            }
            
        };


        function renderAnimatedIMG(freqData) {
            if (current_wait_between_frame < 0) {
                current_img++; if (current_img > total_frames) { current_img = 0; }
                current_wait_between_frame = wait_between_frame;
            } else {
                current_wait_between_frame--;
            }

            let feq = 2;
            let feq2 = 100;
            let feq3 = 75;
            let feq4 = 20;

            let bar_height = (freqData[feq] / 8) * (freqData[feq2] / 10);

            var sat = scaleValue(freqData[feq2], [0, 255], [100, 200]);
            var opacity = scaleValue(freqData[feq3], [0, 255], [0,50]);
            var hue_rotate = scaleValue(freqData[feq4], [0, 255], [0,360]);
            var blur = scaleValue(freqData[21], [0, 255], [0,6]);


            let orig_width = 300;
            let orig_height = 150;

            let img_width = (orig_width / 2) + bar_height;
            let img_height = (orig_height / 2) + bar_height;
            let img_x = (canvas.width / 2) - (img_width / 2);
            let img_y = (canvas.height / 2) - (img_height / 2);


            //let bar_height =0;
            ctx.filter = 'blur(' + blur + 'px) hue-rotate(' + hue_rotate + 'deg) saturate(' + sat + '%) opacity(' + opacity + '%)';
            if (bar_height > 0) {
                ctx.drawImage(image, 300 * current_img, 0, 300, 150, img_x, img_y, img_width, img_height);
            }
            ctx.filter = 'blur(0px) hue-rotate(0deg) saturate(100%) opacity(100%)';
        };

        function renderFrame() {
            let freqData = new Uint8Array(analyser.frequencyBinCount)
            requestAnimationFrame(renderFrame)
            analyser.getByteFrequencyData(freqData)

            ctx.fillStyle = "rgba(0,0,0," + fade + ")";
            ctx.fillRect(0, 0, canvas.width, canvas.height);

            animateBall(ball2, freqData);
            animateBall(ball, freqData);
            renderBar(bar, freqData);
            renderAnimatedIMG(freqData);

        };

        renderFrame()
    }
    render() {
        return (
            <canvas ref="analyzerCanvas" id="analyzer"/>
        );
    }
}


Visual.defaultProps = {
    audio_src: null,
    
};

export default Visual;
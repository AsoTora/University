
function compress($source, $newwidth, $newheight)
{
    $info = getimagesize($source);

    // check for different filetypes and convert them
    if ($info['mime'] == 'image/jpeg' or $info['mime'] == 'image/jpg'){
        return resize_jpeg_image($source, $newwidth, $newheight);
    }
    elseif ($info['mime'] == 'image/png'){
        return resize_png_image($source, $newwidth, $newheight);
    }    
}

function resize_jpeg_image($source, $w, $h, $crop=FALSE) {
    list($width, $height) = getimagesize($source);
    $r = $width / $height;
    if ($crop) {
        if ($width > $height) {
            $width = ceil($width-($width*abs($r-$w/$h)));
        } else {
            $height = ceil($height-($height*abs($r-$w/$h)));
        }
        $newwidth = $w;
        $newheight = $h;
    } else {
        if ($w/$h > $r) {
            $newwidth = $h*$r;
            $newheight = $h;
        } else {
            $newheight = $w/$r;
            $newwidth = $w;
        }
    }
    $src = imagecreatefromjpeg($source);
    $dst = imagecreatetruecolor($newwidth, $newheight);
    imagecopyresampled($dst, $src, 0, 0, 0, 0, $newwidth, $newheight, $width, $height);

    return $dst;
}

function resize_png_image($source, $w, $h, $crop=FALSE) {
    list($width, $height) = getimagesize($source);
    $r = $width / $height;
    if ($crop) {
        if ($width > $height) {
            $width = ceil($width-($width*abs($r-$w/$h)));
        } else {
            $height = ceil($height-($height*abs($r-$w/$h)));
        }
        $newwidth = $w;
        $newheight = $h;
    } else {
        if ($w/$h > $r) {
            $newwidth = $h*$r;
            $newheight = $h;
        } else {
            $newheight = $w/$r;
            $newwidth = $w;
        }
    }

    echo "<br>" . $newheight ."<br>";
    echo "<br>" . $newwidth ."<br>";

    $image = imagecreatefrompng($source);
    $dst = imagecreatetruecolor($width,$height);
    imagealphablending($dst, false);
    imagesavealpha($dst, true);
    imagecopyresampled($dst, $image,0,0,0,0,round($newwidth), round($newheight), round($width), round($height));
    imagepng($dst, $source, 0);

    return $dst;
}
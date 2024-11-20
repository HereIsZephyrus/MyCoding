import xarray as xr
import rasterio
import os
rootPath = "/Users/channingtong/Program/SNU_NDVI_v1"
for root, dirs, files in os.walk(rootPath):
    for filename in files:
        if filename.endswith('.nc'):
            entry = os.path.join(root, filename)
            ds = xr.open_dataset(entry)
            ds = ds.transpose('x', 'y')
            ndvi = ds['NDVI']
            transform = rasterio.transform.from_origin(-180, 90, 0.05, 0.05)
            outputName = entry[0:-3] + '_trans.tif'
            with rasterio.open(
                outputName,
                'w',
                driver='GTiff',
                height=ndvi.shape[0],
                width=ndvi.shape[1],
                count=1,
                dtype=ndvi.dtype,
                crs='EPSG:4326',
                transform=transform,
            ) as dst:
                dst.write(ndvi.values,1)
            print(entry + '--finished');
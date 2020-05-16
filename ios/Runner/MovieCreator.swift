import Foundation
import mobileffmpeg

protocol MovieCreator {
    func createMovie(outputDir: String, scenesDir: String) -> MovieCreatorResult
}

class MovieCreatorImpl : MovieCreator {
    private let infoProvider: MovieInfoProvider
    
    init(infoProvider: MovieInfoProvider) {
        self.infoProvider = infoProvider
    }
    
    func createMovie(outputDir: String, scenesDir: String) -> MovieCreatorResult {
        let info = infoProvider.provideInfo(outputDir: outputDir)
        if (info == nil) {
             return MovieCreatorResultError(message: "Failed to provide movie's info.")
        }
        
        let movieResultCode = MobileFFmpeg.execute(withArguments: [
            "-framerate", "1",
            "-i", "\(scenesDir)/image%03d.jpg",
            "-r", "30",
            "-pix_fmt","yuv420p",
            "-y", info!.moviePath
        ])
        if (movieResultCode != RETURN_CODE_SUCCESS) {
            return MovieCreatorResultError(message: "Failed to create a movie.")
        }
        
        let thumbResultCode = MobileFFmpeg.execute(withArguments: [
            "-i", info!.moviePath,
            "-ss", "00:00:00.500",
            "-vframes", "1",
            info!.thumbPath
        ])
        if (thumbResultCode != RETURN_CODE_SUCCESS) {
            return MovieCreatorResultError(message: "Failed to create a thumb.")
        }
        
        return MovieCreatorResultSuccess(thumb: info!.thumbPath, movie: info!.moviePath)
    }
}

protocol MovieCreatorResult {}

struct MovieCreatorResultSuccess: MovieCreatorResult {
    let thumb: String
    let movie: String
}

struct MovieCreatorResultError: MovieCreatorResult {
    let message: String
}

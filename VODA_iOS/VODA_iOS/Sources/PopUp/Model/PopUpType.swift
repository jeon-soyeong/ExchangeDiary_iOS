//
//  PopUpType.swift
//  VODA_iOS
//
//  Created by 전소영 on 2021/08/13.
//

import Foundation

enum PopUpType {
    case completeWriteStory
    case addPhoto
    case checkStoryContentNil
    case noSaveStory
    case writePeriod
    case reRecord
    case networkError
    case serverError
    
    var message: String? {
        switch self {
        case .completeWriteStory:
            return "교환 일기 작성이 완료되었어요!\n지금 바로 확인해보세요:)"
        case .checkStoryContentNil:
            return "음성 혹은 텍스트 중 하나 이상\n작성해야 일기 등록이 가능해요."
        case .noSaveStory:
            return "페이지를 벗어나면\n작성한 내용은 저장되지 않아요.\n그래도 나가시겠어요?"
        case .reRecord:
            return "새로운 음성을 \n녹음하시겠어요?"
        case .networkError:
            return "네트워크가 불안정하여 접속이\n원활하지 않습니다.\n잠시 후 다시 시도해 주세요."
        case .serverError:
            return "서버 오류가 발생하였습니다.\n이전 화면으로 돌아가거나\n앱을 다시 실행해 주세요."
        case .addPhoto, .writePeriod:
            return nil
        }
    }
  
    var numberOfButton: Int? {
        switch self {
        case .completeWriteStory, .checkStoryContentNil, .networkError, .serverError:
            return 1
        case .noSaveStory, .reRecord:
            return 2
        case .addPhoto, .writePeriod:
            return nil
        }
    }
    
    var labelTopConstraint: Float? {
        let popUpViewHeight = Float(DeviceInfo.screenHeight * 0.2216)
        
        switch self {
        case .completeWriteStory, .checkStoryContentNil, .reRecord:
            return popUpViewHeight * 0.2222
        case .noSaveStory, .networkError, .serverError:
            return popUpViewHeight * 0.1444
        case .addPhoto, .writePeriod:
            return nil
        }
    }
}

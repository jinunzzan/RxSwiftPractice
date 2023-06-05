
import Foundation
import RxSwift

//옵저버블은 구독되기 전에는 그저 정의일 뿐
//확인을 위해선 무조건 서브스크라이브를해야한다

//하나의 엘레멘트만 방출하는 옵저버블 시퀀스 just
print("----just----")
Observable<Int>.just(1)
    .subscribe(onNext: {
        print($0)
    })

print("----Of1----")
//하나 이상의 이벤트 방출가능한 옵저버블 시퀀스
Observable<Int>.of(1, 2, 3, 4, 5)
    .subscribe(onNext: {
        print($0)
    })

//어레이전체를 넣으면 하나의 어레이만 방출
print("----Of2----")
Observable.of([1,2,3,4,5])
    .subscribe(onNext: {
        print($0)
    })

print("----From----")
//from은 어레이만 받아서 각각의 요소를 하나씩 방출합니다.
Observable.from([1,2,3,4,5])
    .subscribe(onNext: {
        print($0)
    })

print("------subscribe1------")
Observable.of(1,2,3)
    .subscribe{
        print($0)
    }

print("------subscribe2------")
Observable.of(1,2,3)
    .subscribe{
        if let element = $0.element{
            print(element)
        }
    }


print("------subscribe3------")
Observable.of(1,2,3)
    .subscribe(onNext: {
        print($0)
    })

print("------Empty------")
Observable<Void>.empty()
    .subscribe{
        print($0)
    }

print("------never------")
Observable.never()
    .subscribe(onNext: {print($0)}, onCompleted: {print("Completedd")})

print("-------range-------")
Observable.range(start: 1, count: 9)
    .subscribe(onNext: {
        print("2*\($0)=\(2*$0)")
    })

print("-------dispose-------")
Observable.of(1, 2, 3)
    .subscribe{
    print($0)
    }
    .dispose()

print("-------disposeBag-------")
let disposeBag = DisposeBag()

Observable.of(1,2,3)
    .subscribe{
        print($0)
    }
    .disposed(by: disposeBag)

print("-------create1-------")
Observable.create { observer -> Disposable in
    observer.onNext(1)
    observer.onCompleted()
    observer.onNext(2)
    return Disposables.create()
}
.subscribe{
    print($0)
}
.disposed(by: disposeBag)

print("-------create2-------")
enum MyError:Error{
    case anError
    
}
Observable.create{observer -> Disposable in
    observer.onNext(1)
    observer.onError(MyError.anError)
    observer.onCompleted()
    observer.onNext(2)
    return Disposables.create()
    
}
.subscribe(onNext: {
    print($0)
}, onError: {
    print($0.localizedDescription)
}, onCompleted: {
    print("completed")
}, onDisposed: {
    print("disposed")
})
.disposed(by: disposeBag)

print("-------deffered1-------")
Observable.deferred{
    Observable.of(1,2,3)
}
.subscribe{
    print($0)
}
.disposed(by: disposeBag)

print("-------deffered2-------")
var 뒤집기: Bool = false

let factory: Observable<String> = Observable.deferred{
    뒤집기 = !뒤집기
    if 뒤집기 {
        return Observable.of("☝️")
    } else{
        return Observable.of("👆🏾")
    }
}
for _ in 0...3{
    factory.subscribe(onNext: {
        print($0)
    })
    .disposed(by:disposeBag)

}
   
